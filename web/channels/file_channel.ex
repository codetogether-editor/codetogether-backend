defmodule Codetogether.FileChannel do
  use Codetogether.Web, :channel

  alias Codetogether.File

  def join("file:" <> file_id, _message, socket) do
    case File.join_file(file_id, socket.assigns.user) do
      {:ok, file} ->
        {:ok, assign(socket, :file, file)}
      {:error, errors} ->
        {:error, errors}
    end
  end

  def handle_in("event", data, socket) do
    broadcast_from!(socket, "event", data)
    File.add_event!(socket.assigns.file, data)
    {:noreply, socket}
  end
end
