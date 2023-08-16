defmodule GpxPhoenix.Repo.Migrations.CreateClimbs do
  use Ecto.Migration

  def up do
    create table(:climbs, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :name, :string
      add :elevation, :integer

      timestamps()
    end

    execute("SELECT AddGeometryColumn('climbs', 'geom', 3857, 'MULTILINESTRINGZ', 3);")
  end

  def down do
    drop table(:climbs)
  end
end
