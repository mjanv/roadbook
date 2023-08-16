defmodule Roadbook.Climbs.Providers.ColsCyclisme do
  @moduledoc false

  @base "https://www.cols-cyclisme.com"

  require Logger

  def load do
    regions = load_regions()
    n = length(regions)

    regions
    |> Enum.with_index(fn {_, name, _} = region, i ->
      climbs = load_region_climbs(region)
      Logger.info("[#{i}/#{n}] Region #{name} (#{length(climbs)} climbs)")

      climbs
      |> Task.async_stream(fn climb -> load_climb_details(climb) end)
      |> Enum.map(fn {:ok, result} -> result end)
    end)
    |> Enum.flat_map(& &1)
  end

  def load_climb_details({_, _, _, region, country, url}) do
    with req <- Req.new(base_url: @base),
         {:ok, %Req.Response{status: 200, body: body}} <- Req.get(req, url: url),
         {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find(".coordonnees table tr")
      |> parse_climb_details()
      |> then(&Keyword.new(&1 ++ [{:region, region}, {:country, country}, {:url, url}]))
    end
  end

  defp parse_climb_details([]), do: []

  defp parse_climb_details([head | tail]) do
    [parse_line(head)] ++ parse_climb_details(tail)
  end

  defp parse_line(
         {"tr", [],
          [
            {"td", [], [key]},
            {"td", [], [_, " Ouvert"]}
          ]}
       ) do
    {parse_key(key), "Ouvert"}
  end

  defp parse_line(
         {"tr", [],
          [
            {"td", [], [key]},
            {"td", [],
             [
               {"a", [{"href", _}], [value1]},
               separator,
               {"a", [{"href", _}], [value2]}
             ]}
          ]}
       ) do
    {parse_key(key), value1 <> separator <> value2}
  end

  defp parse_line({"tr", [], [{"td", _, [key]}, {"td", _, [{"strong", _, [value]}]}]}) do
    {parse_key(key), value}
  end

  defp parse_line({"tr", [], [{"td", _, [key]}, {"td", _, [value]}]}) do
    {parse_key(key), value}
  end

  defp parse_key(key) do
    key
    |> String.replace("é", "e")
    |> String.replace("% ", "pourcentage_")
    |> String.replace(" :", "")
    |> String.downcase()
    |> String.to_atom()
  end

  def load_region_climbs({_badge, _name, url}) do
    with req <- Req.new(base_url: @base),
         {:ok, %Req.Response{status: 200, body: body}} <- Req.get(req, url: url),
         {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find("table tr")
      |> tl()
      |> Enum.map(&parse_climb/1)
    end
  end

  defp parse_climb(
         {"tr", _,
          [
            {"td", [{"class", "nom"}], [name]},
            {"td", [], [start, {"img", _, []}]},
            {"td", [{"class", "text-right"}], [{"strong", [], [altitude]}]},
            {"td", [], [massif]},
            {"td", [], [country]},
            {"td", [{"class", "text-center"}], [{"a", [{"href", url}], _}]}
          ]}
       ) do
    {name, start, altitude, massif, country, url}
  end

  defp parse_climb(
         {"tr", _,
          [
            {"td", [{"class", "nom"}], [name]},
            {"td", [], [start]},
            {"td", [{"class", "text-right"}], [{"strong", [], [altitude]}]},
            {"td", [], [massif]},
            {"td", [], [country]},
            {"td", [{"class", "text-center"}], [{"a", [{"href", url}], _}]}
          ]}
       ) do
    {name, start, altitude, massif, country, url}
  end

  def load_regions do
    with req <- Req.new(base_url: @base),
         {:ok, %Req.Response{status: 200, body: body}} <- Req.get(req, url: "liste.htm"),
         {:ok, document} <- Floki.parse_document(body) do
      document
      |> Floki.find("article ul li a")
      |> Enum.map(&parse_region/1)
    end
  end

  defp parse_region(
         {"a", [{"href", url}],
          [
            {"span", [{"class", "dpt-nom"}], [name]},
            {"span", [{"class", "badge"}], [badge]}
          ]}
       ) do
    {badge, name, url}
  end
end
