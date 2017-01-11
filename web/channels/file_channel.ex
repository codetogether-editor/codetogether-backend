defmodule Codetogether.FileChannel do
  use Codetogether.Web, :channel

  alias Codetogether.File

  def join("file:" <> file_id, _message, socket) do
    case File.join_file(file_id, socket.assigns.current_user) do
      {:ok, file} ->
        send(self(), :catch_up)
        {:ok, assign(socket, :file, file)}
      {:error, errors} ->
        {:error, errors}
    end
  end

  def handle_in("event", %{"data" => data}, socket) do
    event = File.add_event!(socket.assigns.file, data, socket.assigns.current_user)
    broadcast_from!(socket, "event", event_payload(event))
    {:reply, :ok, socket}
  end

  def handle_in("event", _, socket) do
    {:reply, :error, socket}
  end

  def handle_info(:catch_up, socket) do
    for event <- socket.assigns.file.events do
      push(socket, "event", event_payload(event))
    end
    {:noreply, socket}
  end

  defp event_payload(%{user_id: user_id, data: data}) do
    %{"data" => data, "user_id" => user_id}
  end
end
