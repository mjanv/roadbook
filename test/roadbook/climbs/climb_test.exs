defmodule Roadbook.Stages.ClimbTest do
  use Roadbook.DataCase

  alias Roadbook.Climbs
  alias Roadbook.Climbs.Climb
  alias Roadbook.Positioning.{Point, Segment, Track}

  test "A climb can be create from a Track" do
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
      name: "Track name"
    }

    {:ok, %Climb{id: id}} = Climbs.create_climb(track)
    climb = Climbs.get_climb!(id)
    geojson = Climbs.get_climb_geojson(id)

    assert climb.geom == %Geo.MultiLineStringZ{
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

    assert geojson == %{
             "coordinates" => [
               [
                 [5.721164, 45.182415, 221.305598],
                 [5.721226, 45.182458, 221.305598],
                 [5.721259, 45.182433, 221.305598]
               ]
             ],
             "crs" => %{"properties" => %{"name" => "EPSG:3857"}, "type" => "name"},
             "type" => "MultiLineString"
           }
  end
end
