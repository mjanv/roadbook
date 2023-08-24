defmodule Roadbook.EventStoreTest do
  @moduledoc false

  use ExUnit.Case

  alias Roadbook.EventStore

  test "Event can be dispatched on the {:ok, data} pattern" do
    out =
      {:ok, %{id: "abc"}}
      |> EventStore.ok("a", fn data -> %UserCreated{id: data.id} end)

    events = EventStore.read("a")

    assert out == {:ok, %{id: "abc"}}
    assert events == [%UserCreated{id: "abc"}]
  end

  test "Event can be dispatched on the {:error, reason} pattern" do
    out =
      {:error, :closed}
      |> EventStore.error("b", fn _reason -> %UserNotCreated{} end)

    events = EventStore.read("b")

    assert out == {:error, :closed}
    assert events == [%UserNotCreated{}]
  end

  test "Events can be dispatched on the {:ok, data} or {:error, reason} pattern" do
    out1 =
      {:error, :closed}
      |> EventStore.ok_or(
        "c",
        fn _data -> %UserCreated{} end,
        fn _reason -> %UserNotCreated{} end
      )

    out2 =
      {:ok, %{id: "abc"}}
      |> EventStore.ok_or(
        "c",
        fn data -> %UserCreated{id: data.id} end,
        fn _reason -> %UserNotCreated{} end
      )

    events = EventStore.read("c")

    assert out1 == {:error, :closed}
    assert out2 == {:ok, %{id: "abc"}}
    assert events == [%UserNotCreated{}, %UserCreated{id: "abc"}]
  end
end
