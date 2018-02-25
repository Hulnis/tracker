defmodule Tracker.Social.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.Manage


  schema "manages" do
    field :manager, :id
    field :worker, :id

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [])
    |> validate_required([])
  end
end
