defmodule Roadbook.Positioning.ElevationProfile do
  @moduledoc false

  alias Roadbook.Positioning.{Segment, Point, Vector}

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
end
