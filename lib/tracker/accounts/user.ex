defmodule Tracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Accounts.User
  alias Tracker.Social.Manage


  schema "users" do
    field :email, :string
    field :name, :string
    belongs_to :managed_by, User
    has_many :worker_managed_manage, Manage, foreign_key: :manager_id
    has_many :worker_managed, through: [:worker_managed_manage, :worker]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
