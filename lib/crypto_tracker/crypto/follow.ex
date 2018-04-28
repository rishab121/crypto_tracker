defmodule CryptoTracker.Crypto.Follow do
  use Ecto.Schema
  import Ecto.Changeset

  alias CryptoTracker.Accounts.User
  alias CryptoTracker.Crypto.Currency


  schema "follows" do
    belongs_to :user, User
    belongs_to :currency, Currency

    timestamps()
  end

  @doc false
  def changeset(follow, attrs) do
    follow
    |> cast(attrs, [:user_id, :currency_id])
    |> validate_required([:user_id, :currency_id])
  end
end
