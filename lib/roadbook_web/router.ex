defmodule RoadbookWeb.Router do
  use RoadbookWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RoadbookWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", RoadbookWeb do
    pipe_through :browser

    get "/", PageController, :home

    live_session :default,
      on_mount: [
        RoadbookWeb.Components.NavigationBar
      ] do
      live "/climbs", Climbs.ClimbsLive.Index, :index

      live "/stages", Stages.StageLive.Index, :index
      live "/stages/stage/new", Stages.StageLive.Index, :new
      live "/stages/stage/:id/edit", Stages.StageLive.Index, :edit

      live "/stages/stage/:id", Stages.StageLive.Show, :show
      live "/stages/stage/:id/show/edit", Stages.StageLive.Show, :edit
    end
  end

  if Application.compile_env(:roadbook, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: RoadbookWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
