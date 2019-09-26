defmodule Study.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      StudyWeb.Endpoint,
      # Start cars info collectiong worker
      {DynamicSupervisor, strategy: :one_for_one, name: Monitor.DynamicSupervisor},
      #
      # Starts a worker by calling: Study.Worker.start_link(arg)
      # {Study.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    # one_for_one代表restart的策略，当process terminals，只会重启该process
    opts = [strategy: :one_for_one, name: Study.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    StudyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
