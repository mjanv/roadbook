defmodule RoadbookWeb.Stages.StageLive.Show do
  @moduledoc false

  use RoadbookWeb, :live_view

  alias Roadbook.Stages

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:stage, Stages.get_stage!(id))}
  end

  @impl true
  def handle_event("delete", _params, socket) do
    {:ok, _} = Stages.delete_stage(socket.assigns.stage)

    {:noreply, redirect(socket, to: ~p"/stages")}
  end

  defp page_title(:show), do: "Show Stage"
  defp page_title(:edit), do: "Edit Stage"
end
