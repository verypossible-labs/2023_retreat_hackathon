defmodule RetreatHack do
  def get_temperature do
    temp_hum_sensor_module().get_temperature()
  end

  def get_humidity do
    temp_hum_sensor_module().get_humidity()
  end

  def temp_hum_sensor_module do
    Application.get_env(
      :retreat_hack,
      :temp_hum_sensor_module,
      RetreatHack.TempHumSensor.AHT20
    )
  end
end
