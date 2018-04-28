defmodule CryptoTracker.Repo.Migrations.CreateAlerts do
  use Ecto.Migration

  def change do
    create table(:alerts) do
      add :target, :float
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :currency_id, references(:currencies, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:alerts, [:user_id])
    create index(:alerts, [:currency_id])
  end
end
