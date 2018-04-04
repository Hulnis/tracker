defmodule TrackerWeb.TokenController do
  use TrackerWeb, :controller
  alias Tracker.Accounts.User

  action_fallback TrackerWeb.FallbackController

  def create(conn, %{"name" => name, "pass" => pass}) do
    IO.puts("-----name and pass-----")
    IO.inspect(name)
    IO.inspect(pass)
    IO.puts("-----name and pass-----")
    with {:ok, %User{} = user} <- Tracker.Accounts.get_and_auth_user(name, pass) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
end
