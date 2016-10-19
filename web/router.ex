defmodule Codetogether.Router do
  use Codetogether.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Codetogether do
    pipe_through :api

    get "/", PageController, :index
  end
end
