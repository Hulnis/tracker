defmodule Tracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :body, :text, null: false
      add :title, :string, null: false
      add :time_spent, :integer, deafult: 0
      add :assigned_user_id, references(:users, on_delete: :delete_all), default: nil

      timestamps()
    end

    create index(:tasks, [:assigned_user])
  end
end
