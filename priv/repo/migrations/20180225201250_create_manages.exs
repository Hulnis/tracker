defmodule Tracker.Repo.Migrations.CreateManages do
  use Ecto.Migration

  def change do
    create table(:manages) do
      add :manager_id, references(:user, on_delete: :nothing)
      add :worker_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:manages, [:manager])
    create index(:manages, [:worker])
  end
end
