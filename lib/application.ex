defmodule Roadbook.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Roadbook.Supervisor,
      RoadbookWeb.Supervisor
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Roadbook.Application)
  end

  @impl true
  def config_change(changed, _new, removed) do
    RoadbookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
