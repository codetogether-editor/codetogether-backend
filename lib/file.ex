defmodule Codetogether.File do
  defstruct [:id, :pid]

  alias Codetogether.{File, Repo}

  def create(params, user) do
    %File.Data{user_id: user.id}
    |> File.Data.changeset(params)
    |> Repo.insert
  end

  # TODO: record when user joins file
  def join_file(id, _user) do
    {:ok, find_by_id(id)}
  end

  def find_by_id(id) do
    Repo.get!(File.Data, id)
  end

  def add_event!(file, data) do
    Repo.insert!(%File.Event{file_id: file.id, data: data})
  end
end
