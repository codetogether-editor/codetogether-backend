defmodule Codetogether do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Codetogether.Repo, []),
      supervisor(Codetogether.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Codetogether.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Codetogether.Endpoint.config_change(changed, removed)
    :ok
  end
end
