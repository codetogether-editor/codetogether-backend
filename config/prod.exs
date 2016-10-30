use Mix.Config

config :codetogether, Codetogether.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com", port: 80],
  secret_key_base: {:system, "SECRET_KEY_BASE"},

config :logger, level: :info

config :codetogether, Codetogether.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  pool_size: 20

config :codetogether, Codetogether.OAuth.GitHub,
  client_id:     {:system, "GITHUB_CLIENT_ID"},
  client_secret: {:system, "GITHUB_CLIENT_SECRET"},
  redirect_uri:  {:system, "GITHUB_REDIRECT_URI"}

config :guardiam, Guardian,
  secret_key: {:system, "GUARDIAN_SECRET_KEY"}
