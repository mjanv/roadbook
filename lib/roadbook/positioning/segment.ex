defmodule Roadbook.Positioning.Segment do
  @moduledoc false

  defstruct [:points]

  @type t() :: %__MODULE__{points: [Point.t()]}

  alias Roadbook.Positioning.Point

  def stats(segment) do
    up =
      segment
      |> Enum.map(fn x -> x.gai end)
      |> Enum.filter(fn x -> x > 0 end)
      |> Enum.sum()
      |> Float.round(2)

    down =
      segment
      |> Enum.map(fn x -> x.gai end)
      |> Enum.filter(fn x -> x < 0 end)
      |> Enum.sum()
      |> Float.round(2)

    distance =
      segment
      |> Enum.map(fn x -> x.dis end)
      |> Enum.sum()
      |> Float.round(2)

    [up: up, down: -down, distance: distance]
  end

  def compute_route_from_gpx_data(%__MODULE__{points: points} = segment) do
    points =
      points
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] ->
        Map.merge(b, %{
          dis: Point.haversine_distance(a, b),
          gai: Point.elevation_gain(a, b),
          dir: Point.elevation_direction(a, b)
        })
      end)

    %{segment | points: points}
  end
end
