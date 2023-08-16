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
  end

  scope "/climbs", RoadbookWeb.Climbs, as: :climbs do
    pipe_through :browser

    live "/", ClimbsLive.Index, :index
  end

  scope "/stages", RoadbookWeb.Stages, as: :stages do
    pipe_through :browser

    live "/", StageLive.Index, :index
    live "/stage/new", StageLive.Index, :new
    live "/stage/:id/edit", StageLive.Index, :edit

    live "/stage/:id", StageLive.Show, :show
    live "/stage/:id/show/edit", StageLive.Show, :edit
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
