use Mix.Config

config :codetogether, Codetogether.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/manifest.json"
  secret_key_base: {:system, "SECRET_KEY_BASE"},

config :logger, level: :info

config :codetogether, Codetogether.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 20


import_config "prod.secret.exs"
