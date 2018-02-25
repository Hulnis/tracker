defmodule Tracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :is_manager, :boolean, null: false, default: false
      add :managed_by_id, references(:users, on_delete: :delete_all), default: nil

      timestamps()
    end

    create index(:users, [:managed_by_id])

  end
end
