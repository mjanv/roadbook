defmodule Roadbook.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :roadbook,
    adapter: Ecto.Adapters.Postgres
end
