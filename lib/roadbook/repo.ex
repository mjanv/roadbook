defmodule Roadbook.Repo do
  @moduledoc false

  alias Ecto.Adapters

  use Ecto.Repo,
    otp_app: :roadbook,
    adapter: Ecto.Adapters.Postgres

  def define_extensions do
    Postgrex.Types.define(
      Roadbook.PostgresTypes,
      [Geo.PostGIS.Extension] ++ Adapters.Postgres.extensions(),
      json: Jason
    )
  end
end

Roadbook.Repo.define_extensions()
