defmodule Codetogether.UserController do
  use Codetogether.Web, :controller
  use Guardian.Phoenix.Controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Codetogether.ErrorHandler

  def show(conn, _params, user, _claims) do
    render(conn, "show.json", data: user)
  end
end
