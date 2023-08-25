defmodule Roadbook.Positioning.Segment do
  @moduledoc false

  alias Roadbook.Positioning.Point

  defstruct [:points]

  @type t() :: %__MODULE__{points: [Point.t()]}
end
