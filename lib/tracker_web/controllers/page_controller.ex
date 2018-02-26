defmodule TrackerWeb.PageController do
  use TrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    tasks = Tracker.Social.list_tasks()
    changeset = Tracker.Social.change_tasks(%Tracker.Social.Tasks{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end

  def feed(conn, _params) do
    tasks = Tracker.Accounts.get_tasks_of_workers(conn.assigns[:current_user])
    render conn, "task_report.html", tasks: tasks
  end
end
