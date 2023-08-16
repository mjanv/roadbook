defmodule Roadbook.Stages.Stage do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "stages" do
    field :title, :string
    field :data, :binary

    timestamps()
  end

  @doc false
  def changeset(stage, attrs) do
    stage
    |> cast(attrs, [:data, :title])
    |> validate_required([:data, :title])
  end
end
