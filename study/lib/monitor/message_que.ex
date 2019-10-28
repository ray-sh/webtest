defmodule HL7MessageQue do
  use GenServer
  require Logger

  def dump_table do
    Logger.info("Device table")

    :ets.match(:device_table, {:"$0", :"$1"})
    |> IO.inspect()

    Logger.info("Device ready table")

    :ets.match(:device_table_ready, {:"$0", :"$1"})
    |> IO.inspect()
  end

  def ready_messages() do
    :ets.match(:device_table_ready, {:_, :"$1"})
    |> List.flatten()
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  @impl true
  def init(_) do
    :ets.new(:device_table, [:named_table, :public])
    :ets.new(:device_table_ready, [:named_table, :public])
    # TODO: Need look at the race condition of this buffer
    {:ok, {:device_table, :device_table_ready}}
  end
end
