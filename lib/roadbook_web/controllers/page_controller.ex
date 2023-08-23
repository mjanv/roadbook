defmodule RoadbookWeb.PageController do
  use RoadbookWeb, :controller

  def home(conn, _params) do
    if conn.assigns.current_user do
      redirect(conn, to: ~p"/climbs")
    else
      render(conn, :home, layout: false)
    end
  end
end
