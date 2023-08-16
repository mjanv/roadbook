defmodule Roadbook.Climbs do
  @moduledoc false

  import Ecto.Query, warn: false

  alias Roadbook.Climbs.Climb
  alias Roadbook.Repo

  alias Roadbook.Positioning.Track

  def get_climb!(id) do
    Repo.get!(Climb, id)
  end

  def get_climb_geojson(id) do
    Repo.one!(
      from t in Climb,
        where: t.id == ^id,
        select: fragment("ST_AsGeoJSON(?)::json", t.geom)
    )
  end

  def list_climbs, do: Repo.all(Climb)

  def create_climb(%Track{name: name} = track) do
    %Climb{}
    |> Climb.changeset(%{name: name, elevation: 0, geom: Track.build_geometry(track)})
    |> Repo.insert()
  end
end
