import Config

config :bcrypt_elixir, :log_rounds, 1

config :roadbook, Roadbook.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "roadbook_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :roadbook, Roadbook.EventStore,
  serializer: EventStore.JsonSerializer,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "roadbook_test#{System.get_env("MIX_TEST_PARTITION")}"

config :roadbook, Oban, testing: :inline

config :roadbook, RoadbookWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "T5PzQfnKLrWLdDVsxR57VUTurS+s5Et+To2eg0nwqSzQRlu8c4JWYCj5xDR9Xnwu",
  server: false

config :roadbook, Roadbook.Notifications.Mailer, adapter: Swoosh.Adapters.Test

config :swoosh, :api_client, false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
