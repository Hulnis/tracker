defmodule Tracker.Repo.Migrations.CreateManages do
  use Ecto.Migration

  def change do
    create table(:manages) do
      add :manager_id, on_delete: :delete_all), null: false
      add :worker_id, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:manages, [:manager_id])
    create index(:manages, [:worker_id])
  end
end
