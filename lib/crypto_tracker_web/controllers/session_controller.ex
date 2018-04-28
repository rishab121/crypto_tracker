defmodule CryptoTrackerWeb.SessionController do
    use CryptoTrackerWeb, :controller
  
    alias CryptoTracker.Accounts
    alias CryptoTracker.Accounts.User
  
    def create(conn, %{"name" => name, "password" => password}) do
      user = Accounts.get_and_auth(name,password)
      if user do
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Welcome back #{user.name}")
        |> redirect(to: page_path(conn, :all))
      else
        conn
        |> put_flash(:error, "Username and Password not found")
        |> redirect(to: page_path(conn, :index))
      end
    end
  
    def delete(conn, _params) do
      conn
      |> delete_session(:user_id)
      |> put_flash(:info, "Logged out")
      |> redirect(to: page_path(conn, :index))
    end

  end