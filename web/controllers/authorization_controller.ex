defmodule Logitpho.AuthorizationController do
  use Logitpho.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: __MODULE__

  def logged_in_page(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    text conn, "Yo"
  end

  # handle the case where there's no authenticated user
  #   was found
  def unauthenticated(conn, params) do
    conn
    |> put_status(401)
    |> put_flash(:error, "Authentication required")
    |> redirect(to: page_path(conn, :index))
  end
end
