defmodule RetreatHack.TempHumSensor do
  @callback start_link(keyword()) :: GenServer.on_start()
  @callback get_humidity() :: float()
  @callback get_humidity(identifier()) :: float()
  @callback get_temperature() :: float()
  @callback get_temperature(identifier()) :: float()
end
