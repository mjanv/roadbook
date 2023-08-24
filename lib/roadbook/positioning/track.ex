defmodule Roadbook.Positioning.Track do
  @moduledoc false

  alias Roadbook.Positioning.{ElevationProfile, Segment}

  defstruct [:name, :segments, :profiles]

  @type t() :: %__MODULE__{
          name: String.t(),
          segments: [Segment.t()],
          profiles: [ElevationProfile.t()]
        }

  def compute(%__MODULE__{segments: segments} = track) do
    %{track | profiles: Enum.map(segments, &ElevationProfile.compute/1)}
  end

  def build_geometry(%__MODULE__{segments: segments}) do
    %Geo.MultiLineStringZ{
      coordinates:
        Enum.map(segments, fn segment ->
          Enum.map(segment.points, fn point ->
            {point.lon, point.lat, point.ele}
          end)
        end),
      srid: 3857
    }
  end
end
