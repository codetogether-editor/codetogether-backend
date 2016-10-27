defmodule Codetogether.AuthController do
  use Codetogether.Web, :controller

  alias Codetogether.{User, TokenView}

  def authenticate(conn, %{"provider" => provider, "code" => code}) do
    case User.from_oauth(provider, code) do
      {:ok, user} ->
        conn  = Guardian.Plug.api_sign_in(conn, user)
        token = Guardian.Plug.current_token(conn)
        render(conn, TokenView, "show.json", token: token)
      {:error, errors} ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "errors.json", errors: errors)
    end
  end
end
