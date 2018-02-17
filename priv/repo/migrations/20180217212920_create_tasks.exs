defmodule Tracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :body, :text
      add :title, :string
      add :time_spent, :integer
      add :assigned_user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:assigned_user])
  end
end
