import Config

config :roadbook, Roadbook.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "roadbook_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :roadbook, Roadbook.EventStore,
  serializer: EventStore.JsonSerializer,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "roadbook_dev"

config :roadbook, RoadbookWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  https: [
    port: 4001,
    cipher_suite: :strong,
    certfile: "priv/cert/selfsigned.pem",
    keyfile: "priv/cert/selfsigned_key.pem"
  ],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "+pmFQOBg+eDKA9HNL9roRe//ditq4LKTtzXF6xUcAINIfn8bkyH0y8oD9GpUKWwG",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

config :roadbook, RoadbookWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/roadbook_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :roadbook, dev_routes: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :swoosh, :api_client, false
