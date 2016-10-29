defmodule Rumbl.UserController do
  alias Rumbl.User
  use Rumbl.Web, :controller
  plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(Rumbl.User)
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.html", user: Repo.get(Rumbl.User, id)
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user}         ->
        conn |> Rumbl.Auth.login(user) |> put_flash(:info, "#{user.name} created!")
             |> redirect(to: user_path(conn, :index))
      {:error, changeset} -> render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn |> put_flash(:error, "You must be logged in to access that page") |> redirect(to: page_path(conn, :index))
           |> halt
    end
  end
end
