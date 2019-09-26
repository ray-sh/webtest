defmodule Monitor.DynamicSupervisor do
   use DynamicSupervisor

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def all_cars_status() do
   __MODULE__
   |> DynamicSupervisor.which_children()
   |> Enum.map( fn {_,pid,_,_} ->
      GenServer.call(pid,:pop)
   end)
  end
end