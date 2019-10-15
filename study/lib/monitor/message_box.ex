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
    |>String.trim()
    |>String.split("\r")
    |>handle(%DeviceInfo{})
    |>IO.inspect()



    {:ok, :application_accept}
  end

  def dispatch(message) do
    Logger.warn(
      "New disaptch: #{
        inspect(message)
      }"
    )
    {:ok, :application_reject}
  end

  def alloc_ets(name) do

  end

  def handle([],deviceInfo), do: deviceInfo
  def handle([head | tail], deviceInfo) do

    div = handle_message(head, deviceInfo)

    handle(tail, div)
  end

  def handle_message(<<"MSH|", head::binary>>, deviceInfo) do
    id =
    String.split(head,"|")
    |> Enum.at(1)
    %{deviceInfo | id: id}
  end

  def handle_message(<<"PID|", _head::binary>>, deviceInfo) do
    deviceInfo
  end

  def handle_message(<<"PV1|", _head::binary>>, deviceInfo) do
    deviceInfo
  end

  def handle_message(<<"OBR|", head::binary>>, deviceInfo) do
    time_stamp =
    String.split(head,"|")
    |> Enum.at(-1)
    %{deviceInfo | time_stamp: time_stamp}
  end

  def handle_message(<<"OBX|1|", _head::binary>>, deviceInfo), do: deviceInfo
  def handle_message(<<"OBX|2|", _head::binary>>, deviceInfo), do: deviceInfo
  def handle_message(<<"OBX|3|", _head::binary>>, deviceInfo), do: deviceInfo
  def handle_message(<<"OBX|4|", _head::binary>>, deviceInfo), do: deviceInfo

end