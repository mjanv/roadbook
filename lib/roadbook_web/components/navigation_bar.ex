defmodule RoadbookWeb.Components.NavigationBar do
  @moduledoc false

  use Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    {:cont, attach_hook(socket, :active, :handle_params, &set_active/3)}
  end

  defp set_active(params, _url, socket) do
    active =
      case {socket.view, socket.assigns.live_action} do
        {RoadbookWeb.Climbs.ClimbsLive.Index, _} -> :home
        {RoadbookWeb.Stages.StageLive.Index, _} -> :stages
        {_, _} -> :home
      end

    {:cont, assign(socket, active: active)}
  end
end
