defmodule RetreatHack.CloudComm do
  @callback start_link(keyword()) :: GenServer.on_start()
  @callback publish_message(identifier(), String.t()) :: :ok | {:error, atom()}
end
