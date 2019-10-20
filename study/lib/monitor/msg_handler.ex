defmodule MsgHandler do
  # we don't want to restart the GenServer for now.
  # TODO: How to handle the client connection not stable issue, we need test the case that cars send message first
  # then disconnect, after a while reconnect.
  use GenServer, restart: :temporary

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl true
  def init(args), do: {:ok, args}

  '''
  Handle call 和handle message会串行执行吗？实验结果是会，当handle_call在执行的
  时候，handle_info会被阻塞
  '''

  @impl true
  def handle_call(:frame, _from, state) do
    IO.puts("enter handle call")
    :timer.sleep(10000)
    # {frame, left} = get_frame(state)
    {:reply, state, state}
  end

  @impl true
  def handle_info(msg, state) do
    IO.puts("start to handle info")
    IO.inspect(msg)
    # {:tcp, _, info} = msg
    {:noreply, state ++ [msg]}
  end
end
