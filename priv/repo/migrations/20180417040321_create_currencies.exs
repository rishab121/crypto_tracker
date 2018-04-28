defmodule CryptoTracker.Repo.Migrations.CreateCurrencies do
  use Ecto.Migration

  def change do
    create table(:currencies) do
      add :name, :string, null: false

      timestamps()
    end

  end
end
