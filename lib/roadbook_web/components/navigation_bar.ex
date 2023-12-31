defmodule RoadbookWeb.Components.NavigationBar do
  @moduledoc false

  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    {:cont, attach_hook(socket, :active, :handle_params, &set_active/3)}
  end

  defp set_active(_params, _url, socket) do
    active =
      case {socket.view, socket.assigns.live_action} do
        {RoadbookWeb.Climbs.ClimbsLive.Index, _} -> :climbs
        {RoadbookWeb.Stages.StageLive.Index, _} -> :stages
        {RoadbookWeb.Accounts.UserSettingsLive, _} -> :settings
        _ -> :home
      end

    {:cont, assign(socket, active: active)}
  end
end
