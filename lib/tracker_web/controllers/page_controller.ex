defmodule TrackerWeb.PageController do
  use TrackerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
    posts = Trakcer.Social.list_posts()
    changeset = Trakcer.Social.change_post(%Tracker.Social.Tasks{})
    render conn, "feed.html", posts: posts, changeset: changeset
  end
end
