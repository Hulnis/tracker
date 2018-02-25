defmodule Tracker.Social.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.Manage


  schema "manages" do
    belongs_to :manager_id, User
    belongs_to :worker_id, User

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :worker_id])
    |> validate_required([:manager_id, :worker_id])
  end
end
