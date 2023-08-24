defmodule Roadbook.Accounts.Subcriptions.DeliverUserInstructions do
  @moduledoc false

  use GenServer
  use RoadbookWeb, :verified_routes

  require Logger

  alias Roadbook.Accounts

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
    |> Enum.each(&handle/1)

    {:noreply, state}
  end

  def handle(%UserCreated{id: id}) do
    {:ok, _} =
      Accounts.deliver_user_confirmation_instructions(
        Accounts.get_user!(id),
        &url(~p"/users/confirm/#{&1}")
      )
  end

  def handle(event) do
    Logger.info("#{inspect(event)}")
  end
end
