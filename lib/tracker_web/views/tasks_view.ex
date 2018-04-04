defmodule TrackerWeb.TasksView do
  use TrackerWeb, :view
  alias TrackerWeb.TasksView
  alias TrackerWeb.UserView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TasksView, "tasks.json")}
  end

  def render("show.json", %{tasks: tasks}) do
    %{data: render_one(tasks, TasksView, "tasks.json")}
  end

  def render("tasks.json", %{tasks: tasks}) do
    %{
      id: tasks.id,
      body: tasks.body,
      title: tasks.body,
      is_complete: tasks.is_complete,
      time_spent: tasks.time_spent,
      assigned_user: tasks.assigned_user.name,
      user: render_one(tasks.user, UserView, "user.json")
    }
  end
end
