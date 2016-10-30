use Mix.Config

config :codetogether, Codetogether.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :codetogether, Codetogether.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "codetogether_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :guardian, Guardian,
  allowed_algos: ["HS256"],
  secret_key: "ZpBNKoOWFOAk-B43qXe_Tg"
