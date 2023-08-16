defmodule Roadbook.Climbs.Climb do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "climbs" do
    field(:name, :string)
    field(:elevation, :integer)
    field(:geom, Geo.PostGIS.Geometry)

    timestamps()
  end

  @doc false
  def changeset(track, attrs) do
    track
    |> cast(attrs, [:name, :elevation, :geom])
    |> validate_required([:name, :elevation, :geom])
  end
end
