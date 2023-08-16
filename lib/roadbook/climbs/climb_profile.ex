defmodule Roadbook.Climbs.ClimbProfile do
  @moduledoc false

  alias Roadbook.Positioning.Point

  defstruct [:segment]

  @type t() :: %__MODULE__{
          segment: [Point.t()]
        }

  def breakdown(%__MODULE__{segment: segment}, every \\ 1_000) do
    segment
    |> Enum.chunk_while(
      [],
      fn point, acc ->
        if Enum.sum(Enum.map(acc, & &1.dis)) > every do
          {:cont, Enum.reverse(acc), [point]}
        else
          {:cont, [point | acc]}
        end
      end,
      fn
        [] -> {:cont, []}
        acc -> {:cont, Enum.reverse(acc), []}
      end
    )
    |> Enum.map(fn c ->
      dis = c |> Enum.map(& &1.dis) |> Enum.sum() |> Float.round(0)
      ele = Point.elevation_gain(List.first(c), List.last(c))
      slope = Float.round(100 * ele / dis, 1)

      %{dis: dis, ele: ele, slope: slope}
    end)
  end
end
