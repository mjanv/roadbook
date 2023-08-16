import Config

config :roadbook,
  ecto_repos: [Roadbook.Repo],
  event_stores: [Roadbook.EventStore]

config :roadbook, Roadbook.Repo, types: Roadbook.PostgresTypes

config :roadbook, Oban,
  repo: Roadbook.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

config :roadbook, RoadbookWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: RoadbookWeb.ErrorHTML, json: RoadbookWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Roadbook.PubSub,
  live_view: [signing_salt: "btS2323i"]

config :roadbook, Roadbook.Notifications.Mailer, adapter: Swoosh.Adapters.Local

config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
