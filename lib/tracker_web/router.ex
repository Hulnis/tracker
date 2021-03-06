defmodule TrackerWeb.Router do
  use TrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug(Tracker.CurrentUserPlug)
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TrackerWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/feed", PageController, :feed
    get "/task_report", PageController, :task_report

    resources "/users", UserController
    resources "/tasks", TasksController
    resources "/manages", ManageController

    post "/session", SessionController, :create
    delete "/session", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", TrackerWeb do
    pipe_through :api
    resources "/timeblocks", TimeBlockController, except: [:new, :edit]
  end
end
