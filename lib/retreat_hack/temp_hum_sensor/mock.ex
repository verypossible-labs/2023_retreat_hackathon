defmodule RetreatHack.TempHumSensor.Mock do
  use GenServer

  @behaviour RetreatHack.TempHumSensor

  @impl RetreatHack.TempHumSensor
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl RetreatHack.TempHumSensor
  def get_humidity(_ \\ __MODULE__) do
    Enum.random(20..75) + :rand.uniform()
  end

  @impl RetreatHack.TempHumSensor
  def get_temperature(_ \\ __MODULE__) do
    Enum.random(0..35) + :rand.uniform()
  end

  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end
end
