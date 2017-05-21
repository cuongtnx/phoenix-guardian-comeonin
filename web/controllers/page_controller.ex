defmodule Logitpho.PageController do
  use Logitpho.Web, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
