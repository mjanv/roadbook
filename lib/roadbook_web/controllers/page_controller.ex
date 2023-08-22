defmodule RoadbookWeb.PageController do
  use RoadbookWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
