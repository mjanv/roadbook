defmodule Roadbook.Climbs.Providers.OpenStreetMapTest do
  @moduledoc false

  use ExUnit.Case

  # @moduletag :external

  alias Roadbook.Climbs.Providers.OpenStreetMap

  test "?" do
    assert OpenStreetMap.search("Grenoble, France", "Col de porte, France") == :ok
  end
end
