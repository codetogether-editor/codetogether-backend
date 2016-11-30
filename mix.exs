defmodule Codetogether.Mixfile do
  use Mix.Project

  def project do
    [app: :codetogether,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [mod: {Codetogether, []},
     applications: [:phoenix, :phoenix_pubsub, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :oauth2, :guardian, :corsica]]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.0"},
     {:ecto, "~> 2.1-rc", override: true},
     {:guardian, "~> 0.13", github: "ueberauth/guardian"},
     {:corsica, "~> 0.5"},
     {:postgrex, ">= 0.0.0"},
     {:gettext, "~> 0.11"},
     {:cowboy, "~> 1.0"},
     {:oauth2, "~> 0.7"},
     {:distillery, "~> 0.10"},
     {:tap, "~> 0.1"},
     {:recon, "~> 2.3"},
     {:ex_machina, "~> 1.0", only: :test}]
  end

  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
