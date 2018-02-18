defmodule Tracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :body, :text, null: false
      add :title, :string, null: false
      add :time_spent, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :assigned_user_id, references(:users, on_delete: :delete_all), default: nil

      timestamps()
    end

    create index(:tasks, [:assigned_user_id])
    create index(:tasks, [:user_id])
  end
end
