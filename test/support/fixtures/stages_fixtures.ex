defmodule Roadbook.StagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Roadbook.Stages` context.
  """

  @doc """
  Generate a stage.
  """
  def stage_fixture(attrs \\ %{}) do
    {:ok, stage} =
      attrs
      |> Enum.into(%{
        data: "some data",
        title: "some title"
      })
      |> Roadbook.Stages.create_stage()

    stage
  end
end
