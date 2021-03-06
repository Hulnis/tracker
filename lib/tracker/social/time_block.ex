defmodule Tracker.Social.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Social.TimeBlock
  alias Tracker.Social.Tasks


  schema "timeblocks" do
    field :start_time, :utc_datetime
    field :stop_time, :utc_datetime
    belongs_to :task, Tasks

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :stop_time, :task_id])
    |> validate_required([:start_time, :stop_time, :task_id])
  end
end
