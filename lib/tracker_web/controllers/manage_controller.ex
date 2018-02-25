defmodule TrackerWeb.ManageController do
  use TrackerWeb, :controller

  alias Tracker.Social
  alias Tracker.Social.Manage

  def index(conn, _params) do
    manages = Social.list_manages()
    render(conn, "index.html", manages: manages)
  end

  def new(conn, _params) do
    changeset = Social.change_manage(%Manage{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"manage" => manage_params}) do
    case Social.create_manage(manage_params) do
      {:ok, manage} ->
        conn
        |> put_flash(:info, "Manage created successfully.")
        |> redirect(to: manage_path(conn, :show, manage))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    manage = Social.get_manage!(id)
    render(conn, "show.html", manage: manage)
  end

  def edit(conn, %{"id" => id}) do
    manage = Social.get_manage!(id)
    changeset = Social.change_manage(manage)
    render(conn, "edit.html", manage: manage, changeset: changeset)
  end

  def update(conn, %{"id" => id, "manage" => manage_params}) do
    manage = Social.get_manage!(id)

    case Social.update_manage(manage, manage_params) do
      {:ok, manage} ->
        conn
        |> put_flash(:info, "Manage updated successfully.")
        |> redirect(to: manage_path(conn, :show, manage))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", manage: manage, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    manage = Social.get_manage!(id)
    {:ok, _manage} = Social.delete_manage(manage)

    conn
    |> put_flash(:info, "Manage deleted successfully.")
    |> redirect(to: manage_path(conn, :index))
  end
end
