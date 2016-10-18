defmodule Rumbl.UserController do
  use Rumbl.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(Rumbl.User) 
  end
end
