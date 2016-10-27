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
  end
end
