use Mix.Config

config :codetogether, Codetogether.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: false,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :codetogether, Codetogether.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "codetogether_dev",
  hostname: "localhost",
  pool_size: 10

config :codetogether, Codetogether.OAuth.GitHub,
  client_id:     {:system, "GITHUB_CLIENT_ID"},
  client_secret: {:system, "GITHUB_CLIENT_SECRET"},
  redirect_uri:  "http://localhost:8080"
