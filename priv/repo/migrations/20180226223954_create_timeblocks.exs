defmodule Tracker.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    alter table(:timeblocks) do
      modify :start_time, :utc_datetime
      modify :stop_time, :utc_datetime
    end
  end
end
