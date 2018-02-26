defmodule Tracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start_time, :naive_datetime
      add :stop_time, :naive_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tasks, [:task_id])
  end
end
