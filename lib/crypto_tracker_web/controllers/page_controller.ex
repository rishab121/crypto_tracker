defmodule CryptoTrackerWeb.PageController do
  use CryptoTrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  def all(conn, params) do
    render conn, "all.html" 
    # any_name: params["any_name"]
  end
  def coin(conn, params) do
    render conn, "coin.html", coin_name: params["coin_name"]
  end
  def mycur(conn, params) do
    render conn, "mycur.html"
  end
end
