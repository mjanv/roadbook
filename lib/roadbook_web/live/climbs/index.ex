defmodule RoadbookWeb.Climbs.ClimbsLive.Index do
  use RoadbookWeb, :map_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
