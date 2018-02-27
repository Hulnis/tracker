defmodule TrackerWeb.TimeBlockController do
  use TrackerWeb, :controller

  alias Tracker.Social
  alias Tracker.Social.TimeBlock

  action_fallback TrackerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Social.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    start_time = time_block_params["start_time"]
    stop_time = time_block_params["stop_time"]

    # time_block_params = Map.put(time_block_params, "start_time", ~N[start_time])
    # time_block_params = Map.put(time_block_params, "stop_time",  ~N[stop_time])

    with {:ok, %TimeBlock{} = time_block} <- Social.create_time_block(time_block_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = Social.get_time_block!(id)
    render(conn, "show.json", time_block: time_block)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    time_block = Social.get_time_block!(id)

    with {:ok, %TimeBlock{} = time_block} <- Social.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = Social.get_time_block!(id)
    with {:ok, %TimeBlock{}} <- Social.delete_time_block(time_block) do
      send_resp(conn, :no_content, "")
    end
  end
end
