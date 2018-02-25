defmodule Tracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :managed_by, references(:users, on_delete: :delete_all), default: nil

      timestamps()
    end

  end
end
