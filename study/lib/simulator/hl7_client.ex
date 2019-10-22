defmodule HL7Client do
  @doc """
  TODO:
  1.Stop the GenServer

  """
  require Logger
  @default_server "127.0.0.1"
  @product_server "35.185.137.46"

  use GenServer

  def switch(stop \\ true) when is_boolean(stop) do
    case stop do
      true ->
        GenServer.cast(__MODULE__, :stop_send)

      _ ->
        GenServer.cast(__MODULE__, :stop_send)
    end
  end

  def start_link(server_ip \\ @default_server, port \\ 5000, send_interval \\ 5) do
    id =
      "dev-#{Enum.random(1000..9999)}"
      |> String.to_atom()

    Logger.debug("start client #{id}")
    GenServer.start_link(__MODULE__, [server_ip, port, send_interval, id], name: id)
  end

  def ip_tuple(ip_str) do
    ip_str
    |> String.split(".")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  @impl true
  def init([server_ip, port, send_interval, id]) do
    server = {ip_tuple(server_ip), port}
    Logger.info("Connect server  #{inspect(server)}")
    {:ok, socket} = MLLP.Sender.start_link(server)
    :timer.send_after(send_interval * 1000, :send_message)
    {:ok, {socket, send_interval, true, id}}
  end

  @impl true
  def handle_info(:send_message, state) do
    if elem(state, 2) do
      Logger.debug("start to send message to HL7 server")
      MLLP.Sender.async_send_message(elem(state, 0), SimMessage.msg_d_series(elem(state, 3)))
    end

    :timer.send_after(elem(state, 1) * 1000, :send_message)
    {:noreply, state}
  end

  @impl true
  def handle_cast(:stop_send, state), do: {:noreply, Tuple.insert_at(state, 2, false)}

  @impl true
  def handle_cast(:start_send, state), do: {:noreply, Tuple.insert_at(state, 2, true)}
end
