# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :codetogether,
  ecto_repos: [Codetogether.Repo]

# Configures the endpoint
config :codetogether, Codetogether.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fGTLAgrpEHfzxxxAvIfNCzzI1jP2gnrzKSRN9xh+9QH9pykJNALTcPJEr5unwUzq",
  render_errors: [view: Codetogether.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Codetogether.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
