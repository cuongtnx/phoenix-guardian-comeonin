defmodule Logitpho.Router do
  use Logitpho.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Logitpho.Plugs.Context
  end

  scope "/", Logitpho do
    pipe_through :browser

    get "/login", AuthenticationController, :login
    post "/login", AuthenticationController,  :authenticate
  end

  scope "/", Logitpho do
    pipe_through [:browser, :browser_auth]

    get "/", PageController, :index

    get "/logged_in_page", AuthorizationController, :logged_in_page
    resources "/users", UserController, only: [:index, :new, :create, :show, :edit, :update ]
    delete "/logout", AuthenticationController,  :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Logitpho do
  #   pipe_through :api
  # end
end
