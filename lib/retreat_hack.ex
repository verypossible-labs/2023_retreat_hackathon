defmodule RetreatHack do
  def get_temperature do
    temp_hum_sensor_module().get_temperature()
  end

  def get_humidity do
    temp_hum_sensor_module().get_humidity()
  end

  def cloud_comm_module do
    Application.get_env(
      :retreat_hack,
      :cloud_comm_module,
      RetreatHack.CloudComm.Mqtt
    )
  end

  def temp_hum_sensor_module do
    Application.get_env(
      :retreat_hack,
      :temp_hum_sensor_module,
      RetreatHack.TempHumSensor.AHT20
    )
  end
end
