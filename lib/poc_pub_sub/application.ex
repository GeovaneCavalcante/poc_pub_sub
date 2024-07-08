defmodule PocPubSub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    credentials =
      "/Users/geovanefeitosacavalcante/www/poc_pub_sub/certs/sa2.json"
      |> File.read!()
      |> Jason.decode!()

    source = {:service_account, credentials}

    children = [
      PocPubSubWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:poc_pub_sub, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PocPubSub.PubSub},
      # Start a worker by calling: PocPubSub.Worker.start_link(arg)
      # {PocPubSub.Worker, arg},
      # Start to serve requests, typically the last entry
      PocPubSubWeb.Endpoint,
      {Goth, name: MyApp.Goth, source: source}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PocPubSub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PocPubSubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
