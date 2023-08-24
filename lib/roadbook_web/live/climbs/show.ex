defmodule RoadbookWeb.Climbs.ClimbsLive.Show do
  @moduledoc false

  use RoadbookWeb, :live_view

  # alias Roadbook.Climbs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => _id}, _, socket) do
    ccc = %{
      background: "rgb(103, 191, 94, 0.15)",
      border: "#67bf5e"
    }

    colors = [ccc, ccc, ccc, ccc, ccc, ccc, ccc, ccc, ccc]
    points = [156, 229, 292, 356, 363, 384, 404, 487, 581]

    {:noreply, assign(socket, points: points, colors: colors)}
  end
end
