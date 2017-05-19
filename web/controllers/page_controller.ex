defmodule Logitpho.PageController do
  use Logitpho.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
