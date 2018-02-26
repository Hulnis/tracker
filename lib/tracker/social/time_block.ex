defmodule Tracker.Social.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.TimeBlock


  schema "timeblocks" do
    field :start_time, :naive_datetime
    field :stop_time, :naive_datetime
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :stop_time])
    |> validate_required([:start_time, :stop_time])
  end
end
