defmodule Codetogether.PingChannel do
  use Codetogether.Web, :channel
  import Guardian.Phoenix.Socket

  def join("ping", _message, socket) do
    {:ok, socket}
  end

  def handle_in("ping", %{"msg" => message}, socket) do
    user = current_resource(socket)
    broadcast!(socket, "pong", %{msg: message, from: user.id})
  end
end
