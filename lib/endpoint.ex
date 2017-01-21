defmodule Codetogether.Endpoint do
  use Phoenix.Endpoint, otp_app: :codetogether

  socket "/socket", Codetogether.UserSocket

  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Corsica,
    origins: ["http://localhost", "http://127.0.0.1:8080", "http://code-together.herokuapp.com"],
    allow_headers: ["content-type", "authorization"]

  plug Codetogether.Router
end
