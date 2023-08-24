defmodule Roadbook.Accounts.Subcriptions.Logger do
  @moduledoc false

  use GenServer

  require Logger

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  @impl true
  def init(args) do
    :ok = Roadbook.EventStore.subscribe("users")
    {:ok, args}
  end

  @impl true
  def handle_info({:events, events}, state) do
    events
    |> Enum.map(& &1.data)
    |> Enum.each(fn event -> Logger.info("#{inspect(event)}") end)

    {:noreply, state}
  end
end
