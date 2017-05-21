defmodule Logitpho.AuthorizationController do
  use Logitpho.Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: authentication_path(conn, :login))
    |> halt()
  end
end
