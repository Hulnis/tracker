defmodule Tracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :naive_datetime
      add :stop_time, :naive_datetime

      timestamps()
    end

    create index(:timeblocks, [:task_id])
  end
end
