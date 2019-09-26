defmodule MsgHandler do
   #we don't want to restart the GenServer for now.
   #TODO: How to handle the client connection not stable issue, we need test the case that cars send message first
   # then disconnect, after a while reconnect. We hou
   use GenServer, restart: :temporary
   def start_link(_) do
      GenServer.start_link(__MODULE__, [])
   end

   @impl true
   def init(args), do: {:ok, args}

   @impl true
   def handle_call(:pop, _from, state) do
      {:reply, state, state}
   end

   @impl true
   def handle_info(msg, state) do
      IO.inspect(msg)
      {:tcp, _, info} = msg
      {:noreply, [info|state]}
   end

end