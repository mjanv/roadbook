defmodule RoadbookWeb.Stages.StageLive.Index do
  use RoadbookWeb, :live_view

  alias Roadbook.Stages
  alias Roadbook.Stages.Stage

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :stages, Stages.list_stages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Stage")
    |> assign(:stage, Stages.get_stage!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Stage")
    |> assign(:stage, %Stage{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Stages")
    |> assign(:stage, nil)
  end

  @impl true
  def handle_info({RoadbookWeb.Stages.StageLive.FormComponent, {:saved, stage}}, socket) do
    {:noreply, stream_insert(socket, :stages, stage)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    stage = Stages.get_stage!(id)
    {:ok, _} = Stages.delete_stage(stage)

    {:noreply, stream_delete(socket, :stages, stage)}
  end
end
