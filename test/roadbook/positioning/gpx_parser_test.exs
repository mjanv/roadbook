defmodule Roadbook.Positioning.GpxParserTest do
  @moduledoc false

  use ExUnit.Case

  alias Roadbook.Positioning.{GpxParser, Point, Segment, Track}

  @contents """
  <?xml version='1.0' encoding='UTF-8'?>
  <gpx version="1.1" creator="https://www.komoot.de" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
    <metadata>
      <name>Track name</name>
      <author>
        <link href="https://www.komoot.de">
          <text>komoot</text>
          <type>text/html</type>
        </link>
      </author>
    </metadata>
    <trk>
      <name>Track name</name>
      <trkseg>
        <trkpt lat="45.182415" lon="5.721164">
          <ele>221.305598</ele>
          <time>2023-08-16T16:03:25.788Z</time>
        </trkpt>
        <trkpt lat="45.182458" lon="5.721226">
          <ele>221.305598</ele>
          <time>2023-08-16T16:03:30.029Z</time>
        </trkpt>
        <trkpt lat="45.182433" lon="5.721259">
          <ele>221.305598</ele>
          <time>2023-08-16T16:03:32.390Z</time>
        </trkpt>
      </trkseg>
    </trk>
  </gpx>
  """

  test "GPX files from Koomot export feature can be parsed" do
    assert GpxParser.gpx_parse(@contents) == %Track{
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
  end
end
