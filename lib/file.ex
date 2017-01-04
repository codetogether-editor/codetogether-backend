defmodule Codetogether.File do
  import Ecto.Query, only: [from: 2]

  alias Codetogether.{File, Repo}

  def create(params, user) do
    %File.Data{owner_id: user.id}
    |> File.Data.changeset(params)
    |> Repo.insert
  end

  def join_file(id, user) do
    file = find_by_id(id)
    user = record_file_user(file, user)
    {:ok, update_in(file.users, &[user | &1])}
  end

  def find_by_id(id) do
    Repo.get!(file_query(), id)
  end

  def add_event!(file, data) do
    Repo.insert!(%File.Event{file_id: file.id, data: data})
  end

  defp file_query() do
    from f in File.Data,
      preload: [:events, :users]
  end

  defp record_file_user(file, user) do
    data = %File.User{file_id: file.id, user_id: user.id}
    Repo.insert!(data, on_conflict: :nothing)
  end
end
