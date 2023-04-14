import Config

# Add configuration that is only needed when running on the host here.
config :retreat_hack,
  temp_hum_sensor_module: RetreatHack.TempHumSensor.Mock
