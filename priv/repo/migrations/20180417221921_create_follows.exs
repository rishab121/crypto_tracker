defmodule CryptoTracker.Repo.Migrations.CreateFollows do
  use Ecto.Migration

  def change do
    create table(:follows) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :currency_id, references(:currencies, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:follows, [:user_id])
    create index(:follows, [:currency_id])
  end
end
