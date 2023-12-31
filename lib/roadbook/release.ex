defmodule Roadbook.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """

  @app :roadbook

  alias EventStore.Tasks

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp stores do
    Application.fetch_env!(@app, :event_stores)
  end

  defp load_app do
    Application.load(@app)
  end

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end

    for store <- stores() do
      :ok = Tasks.Create.exec(store.config(), [])
      :ok = Tasks.Init.exec(store.config(), [])
      :ok = Tasks.Migrate.exec(store.config(), [])
    end
  end

  def rollback(repo, version) do
    load_app()

    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end
end
