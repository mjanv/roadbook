defmodule Roadbook.Positioning.TrackTest do
  @moduledoc false

  use ExUnit.Case

  alias Roadbook.Positioning.{Point, Segment, Track}

  test "Geometry data can be built from a Track" do
    track = %Track{
      segments: [
        %Segment{
          points: [
            %Point{pos: 0, lat: 45.182415, lon: 5.721164, ele: 221.305598},
            %Point{pos: 1, lat: 45.182458, lon: 5.721226, ele: 221.305598},
            %Point{pos: 2, lat: 45.182433, lon: 5.721259, ele: 221.305598}
          ]
        }
      ],
      name: 'Track name'
    }

    assert Track.build_geometry(track) == %Geo.MultiLineStringZ{
             coordinates: [
               [
                 {5.721164, 45.182415, 221.305598},
                 {5.721226, 45.182458, 221.305598},
                 {5.721259, 45.182433, 221.305598}
               ]
             ],
             srid: 3857,
             properties: %{}
           }
  end
end
