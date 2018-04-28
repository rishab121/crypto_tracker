defmodule CryptoTrackerWeb.AlertController do
  use CryptoTrackerWeb, :controller

  alias CryptoTracker.Crypto
  alias CryptoTracker.Crypto.Alert

  def index(conn, _params) do
    alerts = Crypto.list_alerts()
    render(conn, "index.html", alerts: alerts)
  end

  def new(conn, _params) do
    changeset = Crypto.change_alert(%Alert{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"alert" => alert_params}) do
    case Crypto.create_alert(alert_params) do
      {:ok, alert} ->
        conn
        |> put_flash(:info, "Alert created successfully.")
        |> redirect(to: alert_path(conn, :show, alert))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    alert = Crypto.get_alert!(id)
    render(conn, "show.html", alert: alert)
  end

  def edit(conn, %{"id" => id}) do
    alert = Crypto.get_alert!(id)
    changeset = Crypto.change_alert(alert)
    render(conn, "edit.html", alert: alert, changeset: changeset)
  end

  def update(conn, %{"id" => id, "alert" => alert_params}) do
    alert = Crypto.get_alert!(id)

    case Crypto.update_alert(alert, alert_params) do
      {:ok, alert} ->
        conn
        |> put_flash(:info, "Alert updated successfully.")
        |> redirect(to: alert_path(conn, :show, alert))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", alert: alert, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    alert = Crypto.get_alert!(id)
    {:ok, _alert} = Crypto.delete_alert(alert)

    conn
    |> put_flash(:info, "Alert deleted successfully.")
    |> redirect(to: alert_path(conn, :index))
  end
end
