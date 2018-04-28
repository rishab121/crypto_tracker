defmodule CryptoTrackerWeb.CurrencyController do
  use CryptoTrackerWeb, :controller

  alias CryptoTracker.Crypto
  alias CryptoTracker.Crypto.Currency

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    currencies = Crypto.list_currencies()
    follows = CryptoTracker.Crypto.follows_map_for(current_user.id)
    #currencies = Enum.reverse(CryptoTracker.Crypto.currency_list_for(conn.assigns[:current_user]))
    render(conn, "index.html", currencies: currencies, follows: follows)
  end

  def new(conn, _params) do
    changeset = Crypto.change_currency(%Currency{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"currency" => currency_params}) do
    case Crypto.create_currency(currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency created successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    currency = Crypto.get_currency!(id)
    render(conn, "show.html", currency: currency)
  end

  def edit(conn, %{"id" => id}) do
    currency = Crypto.get_currency!(id)
    changeset = Crypto.change_currency(currency)
    render(conn, "edit.html", currency: currency, changeset: changeset)
  end

  def update(conn, %{"id" => id, "currency" => currency_params}) do
    currency = Crypto.get_currency!(id)

    case Crypto.update_currency(currency, currency_params) do
      {:ok, currency} ->
        conn
        |> put_flash(:info, "Currency updated successfully.")
        |> redirect(to: currency_path(conn, :show, currency))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", currency: currency, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    currency = Crypto.get_currency!(id)
    {:ok, _currency} = Crypto.delete_currency(currency)

    conn
    |> put_flash(:info, "Currency deleted successfully.")
    |> redirect(to: currency_path(conn, :index))
  end
end
