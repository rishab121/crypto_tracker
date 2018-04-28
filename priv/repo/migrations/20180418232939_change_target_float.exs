defmodule CryptoTracker.Repo.Migrations.ChangeTargetFloat do
  use Ecto.Migration

  def change do
    alter table("alerts") do
      modify :target, :float
    end
  end
end
