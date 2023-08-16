defmodule Roadbook.Repo.Migrations.CreateStages do
  use Ecto.Migration

  def change do
    create table(:stages, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :title, :string
      add :data, :binary

      timestamps()
    end
  end
end
