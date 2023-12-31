defmodule Roadbook.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children = [
      Roadbook.Metrics,
      Roadbook.EventStore,
      Roadbook.Repo,
      {Oban, Application.fetch_env!(:roadbook, Oban)},
      Roadbook.Accounts.Supervisor
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
