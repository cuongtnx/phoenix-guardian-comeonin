defmodule Logitpho.AuthenticationController do
  use Logitpho.Web, :controller

  import Plug.Conn

  alias Logitpho.User

  def login(conn, _params) do
    render conn, "login.html"
  end

  def authenticate(conn, %{"authenticate" => authenticate} = params) do

    %{"email" => email, "password" => password} = authenticate

    case User.authenticate(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Login successfully")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: page_path(conn, :index))
      {:error, error_message} ->
        conn
        |> put_flash(:error, error_message)
        |> render "login.html"
    end
  end

  def logout(conn, _params) do
    conn
    |> Guardian.Plug.sign_out
    |> assign(:current_user, nil)
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
