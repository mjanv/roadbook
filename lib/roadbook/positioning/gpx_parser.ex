defmodule Roadbook.Positioning.GpxParser do
  @moduledoc false

  alias Roadbook.Positioning.{Point, Segment, Track}

  import SweetXml

  def gpx_parse(contents) do
    records =
      contents
      |> xmap(
        name: ~x"//gpx/trk/name/text()",
        segment: [
          ~x"//gpx/trk/trkseg/trkpt"l,
          ele: ~x"./ele/text()"f,
          lat: ~x"./@lat"f,
          lon: ~x"./@lon"f
        ]
      )

    segments =
      [records.segment]
      |> Enum.map(fn segment ->
        points =
          Enum.with_index(
            segment,
            fn record, i ->
              %Point{lat: record.lat, lon: record.lon, ele: record.ele, pos: i}
            end
          )

        %Segment{points: points}
      end)

    %Track{name: records.name, segments: segments}
  end

  def read(path) do
    path
    |> File.read!()
    |> gpx_parse()
  end
end
