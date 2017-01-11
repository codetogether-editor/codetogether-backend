defmodule Codetogether.Router do
  use Codetogether.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Codetogether do
    pipe_through :api

    post "/auth/:provider", AuthController, :authenticate

    get "/user", UserController, :me
    resources "/users", UserController, only: [:show]

    resources "/files", FileController, only: [:create, :show]
  end
end
