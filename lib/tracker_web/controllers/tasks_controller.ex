defmodule TrackerWeb.TasksController do
  use TrackerWeb, :controller

  alias Tracker.Social
  alias Tracker.Social.Tasks
  alias Tracker.Accounts
  alias Tracker.Social.TimeBlock

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
    assigned_user = Accounts.get_user_by_name(name)
    if (name != "" ) do
      if (assigned_user != nil and assigned_user.managed_by != nil and
        conn.assigns[:current_user].id == assigned_user.managed_by.id) do
        tasks_params = Map.put(tasks_params, "assigned_user_id", assigned_user.id)
      else
        changeset = Social.change_tasks(%Tasks{})
        conn
        |> put_flash(:error, "Error updating assigned user")
        |> render("new.html", changeset: changeset)
      end
    end

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
    time_blocks = Repo.all(from t in TimeBlock, where: t.id == ^id)
    render(conn, "show.html", tasks: tasks, time_blocks: time_blocks)
  end

  def edit(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    changeset = Social.change_tasks(tasks)
    render(conn, "edit.html", tasks: tasks, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tasks" => tasks_params}) do
    tasks = Social.get_tasks!(id)
    name = tasks_params["assigned_user"]
    assigned_user = Accounts.get_user_by_name(name)
    if (name != "" ) do
      if (assigned_user != nil and assigned_user.managed_by != nil and
        conn.assigns[:current_user].id == assigned_user.managed_by.id) do
        tasks_params = Map.put(tasks_params, "assigned_user_id", assigned_user.id)
      else
        changeset = Social.change_tasks(tasks)
        conn
        |> put_flash(:error, "Error updating assigned user")
        |> render("edit.html", changeset: changeset)
      end
    end
    IO.puts("---tasks_params---")
    IO.inspect(tasks_params)

    time_spent = String.to_integer(tasks_params["time_spent"])

    # if (rem(time_spent, 15) == 0) do
    #   tasks_params = Map.put(tasks_params, "time_spent", time_spent)
    case Social.update_tasks(tasks, tasks_params) do
      {:ok, tasks} ->
        conn
        |> put_flash(:info, "Tasks updated successfully.")
        |> redirect(to: tasks_path(conn, :show, tasks))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tasks: tasks, changeset: changeset)
    end
    # else
    #   changeset = Social.change_tasks(tasks)
    #   conn = put_flash(conn, :error, "Must increment time by 15")
    #   render(conn, "edit.html", tasks: tasks, changeset: changeset)
    # end
  end

  def delete(conn, %{"id" => id}) do
    tasks = Social.get_tasks!(id)
    {:ok, _tasks} = Social.delete_tasks(tasks)

    conn
    |> put_flash(:info, "Tasks deleted successfully.")
    |> redirect(to: tasks_path(conn, :index))
  end
end
