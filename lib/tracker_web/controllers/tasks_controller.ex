defmodule TrackerWeb.TasksController do
  use TrackerWeb, :controller

  alias Tracker.Social
  alias Tracker.Social.Tasks
  alias Tracker.Accounts

  def index(conn, _params) do
    tasks = Social.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Social.change_tasks(%Tasks{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tasks" => tasks_params}) do
    tasks_params = Map.put(tasks_params, "user_id", conn.assigns[:current_user].id)
    name = tasks_params["assigned_user"]
    IO.puts("old task params-----------")
    IO.inspect(tasks_params)
    if (name) do
      tasks_params = Map.put(tasks_params, "assigned_user_id", Accounts.get_user_by_name(name).id)
    end
    IO.puts("new task params-----------")
    IO.inspect(tasks_params)
    case Social.create_tasks(tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks created successfully.")
        |> redirect(to: tasks_path(conn, :show, tasks))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    render(conn, "show.html", tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    changeset = Social.change_tasks(tasks)
    render(conn, "edit.html", tasks: tasks, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    tasks = Social.get_tasks!(id)
    name = tasks_params["assigned_user"]
    IO.puts("old task params-----------")
    IO.inspect(tasks_params)
    tasks_params = if (name) do
       Map.put(tasks_params, "assigned_user_id", Accounts.get_user_by_name(name).id)
     end
    IO.puts("new task params-----------")
    IO.inspect(tasks_params)

    case Social.update_tasks(tasks, tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks updated successfully.")
        |> redirect(to: tasks_path(conn, :show, tasks))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tasks: tasks, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    {:ok, _tasks} = Social.delete_tasks(tasks)

    conn
    |> put_flash(:info, "Tasks deleted successfully.")
    |> redirect(to: tasks_path(conn, :index))
  end
end
