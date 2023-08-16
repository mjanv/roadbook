defmodule Roadbook.Climbs.ClimbDetector do
  @moduledoc false

  def find_fronts([], _, fronts), do: Enum.reverse(fronts)

  def find_fronts([%{pos: pos, dir: dir} | tail], current, fronts) when dir != current do
    find_fronts(tail, dir, [pos | fronts])
  end

  def find_fronts([%{pos: _pos, dir: dir} | tail], current, fronts) when dir == current do
    find_fronts(tail, dir, fronts)
  end

  def filter_small_candidates(candidates, size) do
    Enum.filter(candidates, fn {a, b} -> b - a > size end)
  end

  def filter_close_candidates([], _), do: []
  def filter_close_candidates([x], _), do: [x]

  def filter_close_candidates([{a, b}, {c, d} | tail], size) when c - b > size do
    [{a, b}] ++ filter_close_candidates([{c, d}] ++ tail, size)
  end

  def filter_close_candidates([{a, b}, {c, d} | tail], size) when c - b < size do
    [{a, d}] ++ filter_close_candidates(tail, size)
  end

  def find_climbs([%{dir: 1} | _] = diffs) do
    diffs
    |> find_fronts(1, [])
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.map(&List.to_tuple(&1))
    |> filter_small_candidates(30)
    |> filter_close_candidates(150)
    |> Enum.map(fn {a, b} -> Range.new(a, b) end)
  end

  def find_climbs([%{dir: -1} | _] = diffs) do
    diffs
    |> find_fronts(0, [])
    |> tl()
    |> Enum.chunk_every(2, 2, :discard)
    |> Enum.map(&List.to_tuple(&1))
    |> filter_small_candidates(30)
    |> filter_close_candidates(150)
    |> Enum.map(fn {a, b} -> Range.new(a, b) end)
  end

  def annotate_climbs(route) do
    climbs = find_climbs(route)

    route
    |> Enum.map(fn %{pos: pos} = point ->
      is_climb = Enum.any?(climbs, fn climb -> pos in climb end)
      Map.put(point, :is_climb, (is_climb && 0) || 1)
    end)
  end
end
