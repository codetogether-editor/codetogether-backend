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

  plug Codetogether.Router
end
