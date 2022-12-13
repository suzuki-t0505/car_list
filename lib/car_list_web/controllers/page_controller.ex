defmodule CarListWeb.PageController do
  use CarListWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
