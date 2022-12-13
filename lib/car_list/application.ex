defmodule CarList.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CarList.Repo,
      # Start the Telemetry supervisor
      CarListWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CarList.PubSub},
      # Start the Endpoint (http/https)
      CarListWeb.Endpoint
      # Start a worker by calling: CarList.Worker.start_link(arg)
      # {CarList.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CarList.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CarListWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
