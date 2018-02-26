defmodule Tracker.Social.Tasks do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.Tasks
  alias Tracker.Social.TimeBlock


  schema "tasks" do
    field :body, :string
    field :time_spent, :integer
    field :title, :string
    field :is_complete, :boolean
    belongs_to :assigned_user, Tracker.Accounts.User
    belongs_to :user, Tracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Tasks{} = tasks, attrs) do
    tasks
    |> cast(attrs, [:body, :title, :user_id, :assigned_user_id, :is_complete])
    |> validate_required([:body, :title])
  end
end
