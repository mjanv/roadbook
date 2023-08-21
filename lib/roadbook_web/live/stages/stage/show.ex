defmodule RoadbookWeb.Stages.StageLive.Show do
  @moduledoc false

  use RoadbookWeb, :live_view

  alias Roadbook.Positioning.GpxParser
  alias Roadbook.Stages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    route = List.first(GpxParser.read("priv/gps/test_komoot.gpx").segments)

    map =
      MapLibre.new(
        style: :terrain,
        center: {List.first(route.points).lon, List.first(route.points).lat},
        zoom: 9
      )
      |> MapLibre.add_table_source(
        "map",
        %{
          "lat" => Enum.map(route.points, fn x -> x.lat end),
          "lon" => Enum.map(route.points, fn x -> x.lon end)
        },
        {:lng_lat, ["lon", "lat"]}
      )
      |> MapLibre.add_layer(
        id: "map_circle_1",
        source: "map",
        type: :circle,
        paint: [circle_color: "#edd400", circle_radius: 5, circle_opacity: 0.1]
      )
      |> MapLibre.add_layer(
        id: "map_circle_2",
        source: "map",
        type: :circle,
        paint: [circle_color: "#000000", circle_radius: 2, circle_opacity: 1]
      )

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stage, Stages.get_stage!(id))
     |> assign(:map, map)}
  end

  defp page_title(:show), do: "Show Stage"
  defp page_title(:edit), do: "Edit Stage"
end
