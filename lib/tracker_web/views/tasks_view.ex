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
    assigned_user = if (tasks.assigned_user) do
      tasks.assigned_user.name
    else
      ""
    end
    %{
      id: tasks.id,
      body: tasks.body,
      title: tasks.body,
      is_complete: tasks.is_complete,
      time_spent: tasks.time_spent,
      assigned_user: assigned_user,
      user: render_one(tasks.user, UserView, "user.json")
    }
  end
end
