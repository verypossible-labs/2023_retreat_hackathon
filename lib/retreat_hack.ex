defmodule RetreatHack do
  alias X509.Certificate
  alias X509.PrivateKey

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

  def publish_message do
    {:ok, pid} =
      Tortoise311.Connection.start_link(
        client_id: fetch_config(:device_id),
        server: {
          Tortoise311.Transport.SSL,
          alpn_advertised_protocols: ["x-amzn-mqtt-ca"],
          host: "a9xjoc35wqt4x-ats.iot.us-east-1.amazonaws.com",
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
          server_name_indication: 'a9xjoc35wqt4x-ats.iot.us-east-1.amazonaws.com'
        },
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
