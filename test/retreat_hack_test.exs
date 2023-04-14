defmodule RetreatHackTest do
  use ExUnit.Case
  import Mox
  doctest RetreatHack

  setup do
    verify_on_exit!()
  end

  test "get_humidity/0 returns reading" do
    humidity = 26.2

    RetreatHack.TempHumSensor.TestMock
    |> stub(
      :get_humidity,
      fn ->
        humidity
      end
    )

    assert ^humidity = RetreatHack.get_humidity()
  end

  test "get_temperature/0 returns reading" do
    temperature = 20.60

    RetreatHack.TempHumSensor.TestMock
    |> stub(
      :get_temperature,
      fn ->
        temperature
      end
    )

    assert ^temperature = RetreatHack.get_temperature()
  end
end
