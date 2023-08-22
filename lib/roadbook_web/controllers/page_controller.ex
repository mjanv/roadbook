defmodule RoadbookWeb.PageController do
  use RoadbookWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
    # redirect(conn, to: ~p"/climbs")
  end
end
