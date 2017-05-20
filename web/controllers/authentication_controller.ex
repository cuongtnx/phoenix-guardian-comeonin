defmodule Logitpho.AuthenticationController do
  use Logitpho.Web, :controller
  alias Logitpho.User

  def login(conn, _params) do
    render conn, "login.html"
  end

  def authenticate(conn, %{"authenticate" => authenticate} = params) do

    %{"email" => email, "password" => password} = authenticate
    IO.inspect([email, password])

    case User.authenticate(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Login successfully")
        |> redirect(to: page_path(conn, :index))
      {:error, error_message} ->
        conn
        |> put_flash(:error, error_message)
        |> render "login.html"
    end
  end

  def logout(conn) do
  end
end
