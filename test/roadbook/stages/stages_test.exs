defmodule Roadbook.Stages.StagesTest do
  use Roadbook.DataCase

  alias Roadbook.Stages

  describe "stages" do
    alias Roadbook.Stages.Stage

    import Roadbook.StagesFixtures

    @invalid_attrs %{data: nil, title: nil}

    test "list_stages/0 returns all stages" do
      stage = stage_fixture()
      assert Stages.list_stages() == [stage]
    end

    test "get_stage!/1 returns the stage with given id" do
      stage = stage_fixture()
      assert Stages.get_stage!(stage.id) == stage
    end

    test "create_stage/1 with valid data creates a stage" do
      valid_attrs = %{data: "some data", title: "some title"}

      assert {:ok, %Stage{} = stage} = Stages.create_stage(valid_attrs)
      assert stage.data == "some data"
      assert stage.title == "some title"
    end

    test "create_stage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stages.create_stage(@invalid_attrs)
    end

    test "update_stage/2 with valid data updates the stage" do
      stage = stage_fixture()
      update_attrs = %{data: "some updated data", title: "some updated title"}

      assert {:ok, %Stage{} = stage} = Stages.update_stage(stage, update_attrs)
      assert stage.data == "some updated data"
      assert stage.title == "some updated title"
    end

    test "update_stage/2 with invalid data returns error changeset" do
      stage = stage_fixture()
      assert {:error, %Ecto.Changeset{}} = Stages.update_stage(stage, @invalid_attrs)
      assert stage == Stages.get_stage!(stage.id)
    end

    test "delete_stage/1 deletes the stage" do
      stage = stage_fixture()
      assert {:ok, %Stage{}} = Stages.delete_stage(stage)
      assert_raise Ecto.NoResultsError, fn -> Stages.get_stage!(stage.id) end
    end

    test "change_stage/1 returns a stage changeset" do
      stage = stage_fixture()
      assert %Ecto.Changeset{} = Stages.change_stage(stage)
    end
  end
end
