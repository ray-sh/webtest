defmodule MsgHandler do
   use GenServer
   def start_link() do
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