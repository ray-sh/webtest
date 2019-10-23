defmodule HL7MessageBox do
  @doc """
  这个模块用来的缓存所有的HL7消息，消息的形状大致
  time_stamp1: [device1, device2, ...]
  永远只缓存一个time_stamp的数据

  可以简单的用ETS来代替？
  消息按照设备ID分类，然后只保存一个timestamp的数据

  ?如果dispatch抛出异常，会导致receiver出问题吗？需要弄清楚ranch的OTP结构
  A:如果dispatch出错，会导致server端accept的socket process退出
  Ranch listener #Reference<0.3662458991.3889692673.7160> had connection process started with
  MLLP.Receiver:start_link/4 at #PID<0.571.0> exit with reason: {:function_clause

  ?Dispatch 如何把消息发送给channel
  Actually broadcast_from should works as well.
  The difference with broadcast are that sender doesn’t receive the message, because broadcast_from means
  send the message to everyone else.
  StudyWeb.Endpoint.broadcast_from(self(), "cars:*", "refresh", %{cars: ["car1", "car2222"]}

  数据额的处理和分发：
  1 每个time_stamp的仪器消息是由3个MSH的message组成，这就要求我们缓存每个MSH的处理结果
  2 系统只缓存每个设备的一个time stamp的状态
  3 dispatch广播所有信息，channel会根据当前active的device的状态来决定是否发送数据
  """
  require Logger

  @behaviour MLLP.Dispatcher

  def dispatch(message) when is_binary(message) do
    message
    |> String.trim()
    |> String.split("\r")
    |> handle(%DeviceInfo{})

    {:ok, :application_accept}
  end

  def dispatch(message) do
    Logger.warn("New disaptch: #{inspect(message)}")
    {:ok, :application_reject}
  end

  def ets_name() do
    # ets table必须要public，因为这里我们用name来创建全局唯一的etstable
    :ets.whereis(:device_table)
    |> case do
      :undefined ->
        :ets.new(:device_table, [:named_table, :public])
        :device_table

      _ ->
        :device_table
    end
  end

  def handle([], device_info) do
    # One message has been handled
    # ranch 会给每个client分配一个单独的process来处理 dispatch的message
    Logger.debug("Handle HL7 message within process #{inspect(self())}")
    ets_name = :device_table
    Logger.debug("Query device info by ID #{device_info.id}")

    :ets.lookup(ets_name, device_info.id)
    |> case do
      [] ->
        :ets.insert(ets_name, {device_info.id, device_info})

      [{id, pre_device_info}] ->
        if pre_device_info.time_stamp == device_info.time_stamp do
          new_message = DeviceInfo.merge(pre_device_info, device_info)
          Logger.debug("update the message #{inspect(new_message)}")
          :ets.insert(ets_name, {id, new_message})
        else
          Logger.debug("Send the previous device info #{inspect(pre_device_info)}")
          #TODO：这种发送数据的方式会导致信息的发送不同步，要把完备数据缓存起来，定时发送，同时还要考虑client端如何
          #渲染，这也对数据的发送方式有影响
          #StudyWeb.Endpoint.broadcast_from(self(), "cars:*", "refresh", %{car: pre_device_info})
          :ets.insert(ets_name, {id, device_info})
          :ets.insert(:device_table_ready, {id, pre_device_info})
        end
    end

    device_info
  end

  def handle([head | tail], device_info) do
    div = handle_message(head, device_info)
    handle(tail, div)
  end

  def handle_message(<<"MSH|", head::binary>>, device_info) do
    heads = String.split(head, "|")
    %{device_info | id: Enum.at(heads, 1), time_stamp: Enum.at(heads, 5)}
  end

  def handle_message(<<"PID|", _head::binary>>, device_info) do
    device_info
  end

  def handle_message(<<"PV1|", _head::binary>>, device_info) do
    device_info
  end

  def handle_message(<<"OBR|", _head::binary>>, device_info) do
    device_info
  end

  def handle_message(<<"OBX|", data::binary>>, device_info) do
    cond do
      String.contains?(data, "MDC_ECG_HEART_RATE") ->
        info = String.split(data, "|")
        %{device_info | heart_beat: Enum.at(info, 4)}

      String.contains?(data, "MDC_TTHOR_RESP_RATE") ->
        info = String.split(data, "|")
        %{device_info | breath: Enum.at(info, 4)}

      true ->
        device_info
    end
  end
end
