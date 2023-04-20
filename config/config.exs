# This file is responsible for configuring your application and its
# dependencies.
#
# This configuration file is loaded before any dependency and is restricted to
# this project.
import Config

# Enable the Nerves integration with Mix
Application.start(:nerves_bootstrap)

config :retreat_hack, target: Mix.target()
config :retreat_hack, env: Mix.env()

cert_path = "priv/" <> System.get_env("DEVICE_CERT")
key_path = "priv/" <> System.get_env("DEVICE_KEY")
signer_cert_path = "priv/" <> System.get_env("SIGNER_CERT")

if File.exists?(cert_path) do
  config :retreat_hack, device_cert: File.read!(cert_path)
end

if File.exists?(key_path) do
  config :retreat_hack, device_key: File.read!(key_path)
end

if File.exists?(signer_cert_path) do
  config :retreat_hack, signer_cert: File.read!(signer_cert_path)
end

config :retreat_hack, device_id: System.get_env("DEVICE_ID")

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1678247969"

if Mix.target() == :host do
  import_config "host.exs"
else
  import_config "target.exs"
end

import_config "#{config_env()}.exs"
