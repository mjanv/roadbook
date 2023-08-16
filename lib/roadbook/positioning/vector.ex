defmodule Roadbook.Positioning.Vector do
  @moduledoc false

  defstruct [:pos, :dir, :is_climb, :dis, :gai]

  @type t() :: %__MODULE__{
          pos: integer(),
          dir: -1 | 0 | 1,
          is_climb: 0 | 1,
          dis: integer(),
          gai: integer()
        }
end
