defmodule Codetogether.File do
  import Ecto.Query

  alias Codetogether.{File, Repo}

  def create(params, user) do
    with {:ok, file} <- create_file(params, user) do
      user = record_file_user(file, user)
      {:ok, put_in(file.users, [user])}
    end
  end

  def join_file(id, user) do
    file = find_by_id(id)
    user = record_file_user(file, user)
    {:ok, update_in(file.users, &[user | &1])}
  end

  def find_by_id(id) do
    Repo.get!(file_query(), id)
  end

  def all_for_user(%{id: user_id}) do
    query =
      from f in File.Data,
        join: u in assoc(f, :users),
        where: u.user_id == ^user_id
    Repo.all(query)
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

  defp create_file(params, user) do
    %File.Data{owner_id: user.id}
    |> File.Data.changeset(params)
    |> Repo.insert
  end

end
