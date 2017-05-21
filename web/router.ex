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
    plug Guardian.Plug.EnsureAuthenticated, handler: Logitpho.AuthorizationController
    plug Logitpho.Plugs.Context
  end

  scope "/", Logitpho do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", AuthenticationController, :login
    post "/login", AuthenticationController,  :authenticate
    resources "/users", UserController, only: [:new, :create]
  end

  scope "/", Logitpho do
    pipe_through [:browser, :browser_auth]

    resources "/users", UserController, only: [:index, :show, :edit, :update ]
    delete "/logout", AuthenticationController,  :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", Logitpho do
  #   pipe_through :api
  # end
end
