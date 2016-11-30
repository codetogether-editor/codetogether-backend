defmodule Codetogether.Router do
  use Codetogether.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", Codetogether do
    pipe_through :api

    post "/auth/:provider", AuthController, :authenticate

    get "/user", UserController, :show

    resources "/files", FileController, only: [:create]
  end
end
