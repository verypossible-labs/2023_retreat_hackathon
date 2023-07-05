import Config

# Add configuration that is only needed when running on the host here.
config :retreat_hack,
  temp_hum_sensor_module: RetreatHack.TempHumSensor.Mock

config :vintage_net,
  resolvconf: "/dev/null",
  persistence: VintageNet.Persistence.Null,
  bin_ip: "false"

config :vintage_net_wizard,
  backend: VintageNetWizard.Backend.Mock
