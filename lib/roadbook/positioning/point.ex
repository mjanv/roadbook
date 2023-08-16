defmodule Roadbook.Positioning.Point do
  @moduledoc false

  defstruct [:pos, :lat, :lon, :ele, :dir, :is_climb, :dis, :gai]

  @type t() :: %__MODULE__{
          pos: integer(),
          lat: float(),
          lon: float(),
          ele: float()
        }

  @precision 2

  # Source: https://www.geeksforgeeks.org/program-distance-two-points-earth/
  def haversine_distance(%__MODULE__{lat: lat1, lon: lon1}, %__MODULE__{lat: lat2, lon: lon2}) do
    lat1 = lat1 / 57.29577951
    lon1 = lon1 / 57.29577951
    lat2 = lat2 / 57.29577951
    lon2 = lon2 / 57.29577951

    d =
      1000 * 1.609344 * 3963.0 *
        :math.acos(
          :math.sin(lat1) * :math.sin(lat2) +
            :math.cos(lat1) * :math.cos(lat2) * :math.cos(lon2 - lon1)
        )

    Float.round(d, @precision)
  end

  def elevation_gain(%__MODULE__{ele: ele1}, %__MODULE__{ele: ele2}) do
    Float.round(ele2 - ele1, @precision)
  end

  def elevation_direction(%__MODULE__{} = a, %__MODULE__{} = b) do
    (elevation_gain(a, b) > 0 && 1) || -1
  end
end
