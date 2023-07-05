defmodule RetreatHack.CloudComm.Mqtt do
  use GenServer
  alias X509.{Certificate, PrivateKey}
  @behaviour RetreatHack.CloudComm

  @topic "test"

  @impl RetreatHack.CloudComm
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    {:ok, pid} = connect_to_mqtt()
    {:ok, %{mqtt_pid: pid}}
  end

  @impl RetreatHack.CloudComm
  def publish_message(_pid, message) do
    Tortoise311.publish(fetch_config(:device_id), @topic, message)
  end

  defp connect_to_mqtt do
    Tortoise311.Connection.start_link(
      client_id: fetch_config(:device_id),
      server: {
        Tortoise311.Transport.SSL,
        alpn_advertised_protocols: ["x-amzn-mqtt-ca"],
        host: fetch_config(:mqtt_endpoint),
        port: 443,
        cert: fetch_config(:device_cert) |> Certificate.from_pem!() |> Certificate.to_der(),
        verify: :verify_peer,
        key:
          {:ECPrivateKey,
           fetch_config(:device_key) |> PrivateKey.from_pem!() |> PrivateKey.to_der()},
        cacerts: [
          fetch_config(:signer_cert) |> Certificate.from_pem!() |> Certificate.to_der()
          | ca_certs()
        ],
        versions: [:"tlsv1.2"],
        customize_hostname_check: [
          match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
        ],
        server_name_indication: fetch_config(:mqtt_endpoint) |> String.to_charlist()
      },
      subscriptions: [{@topic, 0}],
      handler: {Tortoise311.Handler.Logger, []}
    )
  end

  def ca_certs() do
    Path.join([:code.priv_dir(:retreat_hack), "ca_certs", "aws"])
    |> File.ls!()
    |> Stream.map(&Path.join([:code.priv_dir(:retreat_hack), "ca_certs", "aws", &1]))
    |> Stream.map(&Path.expand/1)
    |> Stream.map(&File.read!/1)
    |> Stream.map(&X509.Certificate.from_pem!/1)
    |> Enum.map(&X509.Certificate.to_der/1)
  end

  def fetch_config(key) do
    Application.get_env(:retreat_hack, key)
  end
end
