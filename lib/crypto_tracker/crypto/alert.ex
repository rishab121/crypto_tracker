defmodule CryptoTracker.Crypto.Alert do
  use Ecto.Schema
  import Ecto.Changeset


  schema "alerts" do
    field :target, :float, null: false
    belongs_to :user, CryptoTracker.Accounts.User
    belongs_to :currency, CryptoTracker.Crypto.Currency

    timestamps()
  end

  @doc false
  def changeset(alert, attrs) do
    alert
    |> cast(attrs, [:target, :user_id, :currency_id])
    |> validate_required([:target, :user_id, :currency_id])
  end
end
