defmodule Roadbook.Positioning.ElevationProfile do
  @moduledoc false

  alias Roadbook.Positioning.{Point, Segment, Vector}

  defstruct [:vectors]

  @type t() :: %__MODULE__{vectors: [Vector.t()]}

  def compute(%Segment{points: points}) do
    vectors =
      points
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [a, b] ->
        Map.merge(b, %{
          dis: Point.haversine_distance(a, b),
          gai: Point.elevation_gain(a, b),
          dir: Point.elevation_direction(a, b)
        })
      end)

    %__MODULE__{vectors: vectors}
  end

  def stats(%__MODULE__{vectors: vectors}) do
    up =
      vectors
      |> Enum.map(fn x -> x.gai end)
      |> Enum.filter(fn x -> x > 0 end)
      |> Enum.sum()
      |> Float.round(2)

    down =
      vectors
      |> Enum.map(fn x -> x.gai end)
      |> Enum.filter(fn x -> x < 0 end)
      |> Enum.sum()
      |> Float.round(2)

    distance =
      vectors
      |> Enum.map(fn x -> x.dis end)
      |> Enum.sum()
      |> Float.round(2)

    [up: up, down: -down, distance: distance]
  end
end
