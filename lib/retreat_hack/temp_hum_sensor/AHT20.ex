defmodule RetreatHack.TempHumSensor.AHT20 do
  use GenServer
  @behaviour RetreatHack.TempHumSensor

  alias Circuits.I2C

  @address 0x38
  @init_command <<0xBE>>
  @measure_command <<0xAC, 0x33, 0x00>>

  defmodule State do
    @moduledoc false
    defstruct [
      :i2c_ref
    ]
  end

  @impl RetreatHack.TempHumSensor
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl RetreatHack.TempHumSensor
  def get_humidity(pid \\ __MODULE__) do
    GenServer.call(pid, :get_humidity)
  end

  @impl RetreatHack.TempHumSensor
  def get_temperature(pid \\ __MODULE__) do
    GenServer.call(pid, :get_temperature)
  end

  @impl GenServer
  def init(_) do
    {:ok, i2c} = initialize_sensor()
    {:ok, %State{i2c_ref: i2c}}
  end

  defp initialize_sensor do
    {:ok, ref} = I2C.open("i2c-1")
    I2C.write(ref, @address, @init_command)

    {:ok, ref}
  end

  @impl GenServer
  def handle_call(:get_humidity, _from, %State{i2c_ref: i2c} = state) do
    I2C.write(i2c, @address, @measure_command)

    humidity =
      i2c
      |> read()
      |> parse_humidity()

    {:reply, humidity, state}
  end

  @impl GenServer
  def handle_call(:get_temperature, _from, %State{i2c_ref: i2c} = state) do
    I2C.write(i2c, @address, @measure_command)

    temperature =
      i2c
      |> read()
      |> parse_temperature()

    {:reply, temperature, state}
  end

  defp read(i2c) do
    {:ok, <<status>>} = I2C.read(i2c, @address, 1)

    cond do
      Bitwise.band(status, 0x80) == 0 -> I2C.read(i2c, @address, 7)
      true -> read(i2c)
    end
  end

  defp parse_humidity({:ok, <<_status, humidity::size(20), _temp::size(20), _checksum>>}),
    do: humidity / :math.pow(2, 20)

  defp parse_temperature({:ok, <<_status, _humidity::size(20), temp::size(20), _checksum>>}),
    do: temp / :math.pow(2, 20) * 200 - 50
end
