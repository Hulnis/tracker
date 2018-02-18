defmodule Tracker.Social.Tasks do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.Tasks


  schema "tasks" do
    field :body, :string
    field :time_spent, :integer
    field :title, :string
    field :assigned_user, Tracker.Accounts.User
    belongs_to :user, Tracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Tasks{} = tasks, attrs) do
    tasks
    |> cast(attrs, [:body, :title, :time_spent])
    |> validate_required([:body, :title, :time_spent])
  end
end
