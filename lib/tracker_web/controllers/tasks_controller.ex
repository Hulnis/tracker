defmodule TrackerWeb.TasksController do
  use TrackerWeb, :controller

  alias Tracker.Social
  alias Tracker.Social.Tasks
  alias Tracker.Accounts

  action_fallback TrackerWeb.FallbackController

  def index(conn, _params) do
    tasks = Social.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Social.change_tasks(%Tasks{})
    render(conn, "new.json", changeset: changeset)
  end

  def create(conn, %{"tasks" => tasks_params}) do
    tasks_params = Map.put(tasks_params, "user_id", conn.assigns[:current_user].id)
    name = tasks_params["assigned_user"]
    tasks_params = if (name != "") do
       Map.put(tasks_params, "assigned_user_id", Accounts.get_user_by_name(name).id)
     else
       tasks_params
     end
    with {:ok, %Tasks{} = tasks} <- Social.create_tasks(tasks_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", tasks_path(conn, :show, tasks))
      |> render("show.json", tasks: tasks)
    end
  end

  def show(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    render(conn, "show.json", tasks: tasks)
  end

  def edit(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    changeset = Social.change_tasks(tasks)
    render(conn, "edit.json", tasks: tasks, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    {:ok, user_id} = Phoenix.Token.verify(conn, "auth token", token, max_age: 86400)

    tasks = Social.get_tasks!(id)
    name = tasks_params["assigned_user"]
    tasks_params = if (user_id == tasks.user.id and name != "") do
      Map.put(tasks_params, "assigned_user_id", Accounts.get_user_by_name(name).id)
    else
      Map.put(tasks_params, "assigned_user_id", nil)
    end
    time_spent = String.to_integer(tasks_params["time_spent"])

    if rem(time_spent, 15) == 0 and tasks.assigned_user != nil and user_id == tasks.assigned_user.id do
      tasks_params = Map.put(tasks_params, "time_spent", time_spent)
      with {:ok, %Tasks{} = tasks} <- Social.create_tasks(tasks_params) do
          render(conn, "show.json", tasks: tasks)
      end
    else
      render(conn, "show.json", tasks: tasks)
    end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    with {:ok, %Tasks{}} <- Social.delete_tasks(tasks) do
      send_resp(conn, :no_content, "")
    end
  end
end
