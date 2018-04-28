defmodule CryptoTracker.Crypto.Currency do
  use Ecto.Schema
  import Ecto.Changeset

  alias CryptoTracker.Crytpo.Follow

  schema "currencies" do
    field :name, :string, null: false

    #has_many :user_follows, Follow, foreign_key: :user_id
    #has_many :followers through: [:user_follows, :user]

    timestamps()
  end

  @doc false
  def changeset(currency, attrs) do
    currency
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
