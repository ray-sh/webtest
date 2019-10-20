defmodule HL7Client do
  @doc """
  TODO: 
  1.Stop the GenServer

  """
  require Logger
  @default_server "127.0.0.1"

  @product_server "35.185.137.46"

  use GenServer

  def start_link(server_ip \\ @default_server, port \\ 5000, send_interval \\ 5) do
    GenServer.start_link(__MODULE__, [server_ip, port, send_interval], name: __MODULE__)
  end

  def ip_tuple(ip_str) do
    ip_str
    |> String.split(".")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  @impl true
  def init([server_ip, port, send_interval]) do
    server = {ip_tuple(server_ip), port} |> IO.inspect()

    Logger.info("Connect server  #{inspect(server)}")
    {:ok, socket} = MLLP.Sender.start_link(server)
    :timer.send_after(send_interval * 1000, :send_message)
    {:ok, {socket, send_interval, true}}
  end

  @impl true
  def handle_info(:send_message, state) do
    if elem(state, 2) do
      Logger.info("start to send message to HL7 server")
      MLLP.Sender.async_send_message(elem(state, 0), SimMessage.msg_d_series("dev1"))
    end

    :timer.send_after(elem(state, 1) * 1000, :send_message)
    {:noreply, state}
  end

  @impl true
  def handle_cast(:stop_send, state), do: {:noreply, Tuple.insert_at(state, 2, false)}

  @impl true
  def handle_cast(:start_send, state), do: {:noreply, Tuple.insert_at(state, 2, true)}
end
