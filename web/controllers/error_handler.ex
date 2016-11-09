defmodule Codetogether.ErrorHandler do
  import Plug.Conn
  import Phoenix.Controller

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(Codetogether.ErrorView, "unauthenticated.json")
  end
end
