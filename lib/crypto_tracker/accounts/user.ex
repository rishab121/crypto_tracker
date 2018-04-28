defmodule CryptoTracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string, null: false
    field :name, :string, null: false
    field :password_hash, :string, null: false

    field :password, :string, virtual: true

    #has_many :currency_followed, Follow, foreign_key: :currency_id
    #has_many :followed_currencies through: [:currency_followed, :currency]

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> put_pass_hash()
    |> validate_required([:name, :email, :password_hash])
  end

  def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  def put_pass_hash(changeset), do: changeset

end
