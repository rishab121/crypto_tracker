defmodule CryptoTrackerWeb.AllChannel do
  use CryptoTrackerWeb, :channel
  alias CryptoTracker.Allcurrency
  def join("all:"<>name, payload, socket) do
    coins = Allcurrency.new()
    socket = socket
    |> assign(:coins, coins)
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end
  def handle_in("getAllCoins", %{}, socket) do
    coins1 = Allcurrency.getAllCoins()
    socket = assign(socket, :coins, coins1)
    {:reply, {:ok, %{"result" => coins1}}, socket}
  end
  def handle_in("getUserCoins",%{"user_id" => user_id}, socket) do
    currency_list = CryptoTracker.Crypto.getUserCurrency(user_id)
    {:reply, {:ok, %{"currency_list" => currency_list}}, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (all:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end

