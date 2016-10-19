use Mix.Config

config :codetogether,
  ecto_repos: [Codetogether.Repo]

config :codetogether, Codetogether.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fGTLAgrpEHfzxxxAvIfNCzzI1jP2gnrzKSRN9xh+9QH9pykJNALTcPJEr5unwUzq",
  render_errors: [view: Codetogether.ErrorView, accepts: ~w(json)],
  pubsub: [name: Codetogether.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
