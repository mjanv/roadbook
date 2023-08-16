defmodule Roadbook.Positioning.PointTest do
  @moduledoc false

  use ExUnit.Case

  alias Roadbook.Positioning.Point

  test "Haversine distance can be computed between points (in meters)" do
    # 2.0043678382716137
    assert Point.haversine_distance(
             %Point{lat: 53.32055555555556, lon: -1.7297222222222221},
             %Point{lat: 53.31861111111111, lon: -1.6997222222222223}
           ) == 2006.52
  end

  test "Elevation gains can be computed between points (in meters)" do
    assert Point.elevation_gain(
             %Point{ele: 221.4324},
             %Point{ele: 321.78}
           ) == 100.35
  end

  test "Elevation direction can be computed between points (absolute)" do
    assert Point.elevation_direction(
             %Point{ele: 221.4324},
             %Point{ele: 321.78}
           ) == 1

    assert Point.elevation_direction(
             %Point{ele: 321.4324},
             %Point{ele: 100.78}
           ) == -1
  end
end
