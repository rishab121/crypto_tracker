defmodule CryptoTrackerWeb.FollowController do
  use CryptoTrackerWeb, :controller

  alias CryptoTracker.Crypto
  alias CryptoTracker.Crypto.Follow

  action_fallback CryptoTrackerWeb.FallbackController

  def index(conn, _params) do
    follows = Crypto.list_follows()
    render(conn, "index.json", follows: follows)
  end

  def create(conn, %{"follow" => follow_params}) do
    with {:ok, %Follow{} = follow} <- Crypto.create_follow(follow_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", follow_path(conn, :show, follow))
      |> render("show.json", follow: follow)
    end
  end

  def show(conn, %{"id" => id}) do
    follow = Crypto.get_follow!(id)
    render(conn, "show.json", follow: follow)
  end

  def update(conn, %{"id" => id, "follow" => follow_params}) do
    follow = Crypto.get_follow!(id)

    with {:ok, %Follow{} = follow} <- Crypto.update_follow(follow, follow_params) do
      render(conn, "show.json", follow: follow)
    end
  end

  def delete(conn, %{"id" => id}) do
    follow = Crypto.get_follow!(id)
    with {:ok, %Follow{}} <- Crypto.delete_follow(follow) do
      send_resp(conn, :no_content, "")
    end
  end
end
