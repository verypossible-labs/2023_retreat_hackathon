defmodule RetreatHack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RetreatHack.Supervisor]

    children = env_children(env())

    Supervisor.start_link(children, opts)
  end

  def env_children(:test) do
    []
  end

  def env_children(_) do
    [
      RetreatHack.temp_hum_sensor_module()
    ] ++ target_children(target())
  end

  # List all child processes to be supervised
  def target_children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: RetreatHack.Worker.start_link(arg)
      # {RetreatHack.Worker, arg},
    ]
  end

  def target_children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: RetreatHack.Worker.start_link(arg)
      # {RetreatHack.Worker, arg},
    ]
  end

  def env() do
    Application.get_env(:retreat_hack, :env)
  end

  def target() do
    Application.get_env(:retreat_hack, :target)
  end
end
