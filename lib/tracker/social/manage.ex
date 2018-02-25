defmodule Tracker.Social.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.Manage
  alias Tracker.Accounts.User


  schema "manages" do
    belongs_to :manager, User
    belongs_to :worker, User

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :worker_id])
    |> validate_required([:manager_id, :worker_id])
  end
end
