defmodule CryptoTrackerWeb.Router do
  use CryptoTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :get_current_user
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  def get_current_user(conn, params) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = CryptoTracker.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CryptoTrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/all", PageController, :all 
    get "/coin/:coin_name", PageController, :coin    
    get "/mycur", PageController, :mycur
    resources "/users", UserController
    resources "/currencies", CurrencyController
    resources "/alerts", AlertController
    post "/session", SessionController, :create
    delete "/session", SessionController, :delete

  end

  # Other scopes may use custom stacks.
  scope "/api/v1", CryptoTrackerWeb do
     pipe_through :api
     resources "/follows", FollowController, except: [:new, :edit]
  end
end
