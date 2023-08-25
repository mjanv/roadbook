defmodule Mix.Tasks.Providers.Cols do
  @moduledoc false

  use Mix.Task

  alias Roadbook.Climbs.Providers.ColsCyclisme

  @impl Mix.Task
  def run(_args) do
    Application.ensure_all_started(:telemetry)
    Application.ensure_all_started(:req)

    ColsCyclisme.load() |> write_csv()
  end

  defp write_csv(data) do
    data
    |> Enum.map(fn climb ->
      "#{climb[:nom]};#{climb[:depart]};#{climb[:region]};#{climb[:country]};#{climb[:url]}\n"
    end)
    |> then(&File.write!("data/cols_cyclisme_climbs.csv", &1))
  end
end
