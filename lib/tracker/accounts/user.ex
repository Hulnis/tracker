defmodule Tracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Accounts.User
  alias Tracker.Social.Manage


  schema "users" do
    field :email, :string
    field :name, :string
    field :is_manager, :boolean
    has_one :managed_by_manage, User, foreign_key: :worker_id
    has_one :managed_by, through: [:managed_by_manage, :manager]
    has_many :worker_managed_manage, Manage, foreign_key: :manager_id
    has_many :worker_managed, through: [:worker_managed_manage, :worker]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :is_manager])
    |> validate_required([:email, :name, :is_manager])
  end
end
