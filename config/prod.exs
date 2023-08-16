import Config

config :roadbook, RoadbookWeb.Endpoint, cache_static_manifest: "priv/static/cache_manifest.json"

config :swoosh, :api_client, false
# config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: Roadbook.Finch

config :swoosh, local: false

config :logger, level: :info
