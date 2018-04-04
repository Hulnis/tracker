defmodule TrackerWeb.PageController do
  use TrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
  # 
  # def feed(conn, _params) do
  #   tasks = Tracker.Social.list_tasks()
  #   changeset = Tracker.Social.change_tasks(%Tracker.Social.Tasks{})
  #   render conn, "feed.html", tasks: tasks, changeset: changeset
  # end
end
