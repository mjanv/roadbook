defmodule Roadbook.Climbs.ClimbsDetectorTest do
  @moduledoc false

  use ExUnit.Case

  alias Roadbook.Climbs.ClimbProfile

  defp load_profile(name) do
    {segment, []} = Code.eval_file("test/roadbook/climbs/profiles/#{name}.exs")
    segment
  end

  test "Climb profile can be breakdown kilometer by kilometer with the average slope" do
    breakdown = ClimbProfile.breakdown(%ClimbProfile{segment: load_profile("profile_1")})

    assert breakdown == [
             %{dis: 1004.0, ele: 97.88, slope: 9.7},
             %{dis: 665.0, ele: 53.32, slope: 8.0}
           ]

    assert breakdown |> Enum.map(& &1.ele) |> Enum.sum() == 151.2
    assert breakdown |> Enum.map(& &1.dis) |> Enum.sum() == 1669.0
  end

  test "Climb profile can be breakdown 100m by 100m with the average slope" do
    breakdown = ClimbProfile.breakdown(%ClimbProfile{segment: load_profile("profile_1")}, 100)

    assert breakdown == [
             %{dis: 150.0, slope: 4.8, ele: 7.18},
             %{dis: 175.0, slope: 0.0, ele: 0.0},
             %{dis: 134.0, slope: 10.8, ele: 14.42},
             %{dis: 109.0, slope: 2.5, ele: 2.68},
             %{dis: 135.0, slope: 3.3, ele: 4.39},
             %{dis: 137.0, slope: 2.3, ele: 3.1},
             %{dis: 103.0, slope: 1.6, ele: 1.69},
             %{dis: 120.0, slope: 2.8, ele: 3.38},
             %{dis: 109.0, slope: 3.5, ele: 3.85},
             %{dis: 117.0, slope: 6.8, ele: 8.0},
             %{dis: 104.0, slope: 8.6, ele: 8.92},
             %{dis: 112.0, slope: 7.8, ele: 8.7},
             %{dis: 150.0, slope: 4.7, ele: 7.08},
             %{dis: 15.0, slope: 0.0, ele: 0.0}
           ]

    assert breakdown |> Enum.map(& &1.ele) |> Enum.sum() == 73.39
    assert breakdown |> Enum.map(& &1.dis) |> Enum.sum() == 1670.0
  end
end
