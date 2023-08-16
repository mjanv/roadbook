defmodule Roadbook.EventStore do
  @moduledoc false

  use EventStore, otp_app: :roadbook, schema: "events"

  def init(config) do
    {:ok, config}
  end
end
