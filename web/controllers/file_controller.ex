defmodule Codetogether.FileController do
  use Codetogether.Web, :controller
  use Guardian.Phoenix.Controller

  alias Codetogether.File

  plug Guardian.Plug.EnsureAuthenticated, handler: Codetogether.ErrorHandler

  def create(conn, %{"file" => params}, user, _claims) do
    case File.create(params, user) do
      {:ok, file} ->
        conn
        |> put_status(:created)
        |> render("show.json", data: file)
      {:error, errors} ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "errors.json", errors: errors)
    end
  end

  def show(conn, %{"id" => id}, user, _claims) do
    case File.join_file(id, user) do
      {:ok, file} ->
        conn
        |> render("show.json", data: file)
      {:error, errors} ->
        conn
        |> put_status(:bad_request)
        |> render(ErrorView, "errors.json", errors: errors)
    end
  end
end
