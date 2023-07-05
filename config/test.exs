import Config

config :retreat_hack,
  temp_hum_sensor_module: RetreatHack.TempHumSensor.TestMock,
  cloud_comm_module: RetreatHack.CloudComm.TestMock
