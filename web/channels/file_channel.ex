defmodule Codetogether.FileChannel do
  use Codetogether.Web, :channel

  alias Codetogether.File

  def join("file:" <> file_id, _message, socket) do
    case File.join_file(file_id, socket.assigns.user) do
      {:ok, file} ->
        send(self(), :catch_up)
        {:ok, assign(socket, :file, file)}
      {:error, errors} ->
        {:error, errors}
    end
  end

  def handle_in("event", %{"data" => data}, socket) do
    payload = %{"data" => data, "user_id" => socket.assigns.current_user.id}
    broadcast_from!(socket, "event", data)
    File.add_event!(socket.assigns.file, data)
    {:noreply, socket}
  end

  def handle_info(:catch_up, socket) do
    for event <- socket.assigns.file.events do
      push(socket, "event", event.data)
    end
    {:noreply, socket}
  end
end
