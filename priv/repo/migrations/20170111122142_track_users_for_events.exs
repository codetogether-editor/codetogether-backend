defmodule Codetogether.Repo.Migrations.TrackUsersForEvents do
  use Ecto.Migration

  alias Codetogether.Repo

  def change do
    Repo.delete_all("file_events")

    alter table(:file_events) do
      add :user_id, references(:accounts, type: :binary_id), null: false
    end
  end
end
