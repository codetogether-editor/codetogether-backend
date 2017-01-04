defmodule Codetogether.UserController do
  use Codetogether.Web, :controller
  use Guardian.Phoenix.Controller

  alias Codetogether.{User, File}

  plug Guardian.Plug.EnsureAuthenticated, handler: Codetogether.ErrorHandler

  def show(conn, %{"id" => id}, _user, _claims) do
    render(conn, "show.json", data: User.by_id(id))
  end

  def me(conn, _params, user, _claims) do
    render(conn, "show.json", data: user, files: File.all_for_user(user))
  end
end
