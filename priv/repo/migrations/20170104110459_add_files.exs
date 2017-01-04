defmodule Codetogether.Repo.Migrations.AddFiles do
  use Ecto.Migration

  def change do
    create table(:files, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false

      add :owner_id, references(:accounts, type: :binary_id), null: false

      timestamps()
    end

    create table(:file_events) do
      add :data, :map, null: false

      add :file_id, references(:files, type: :binary_id), null: false
    end

    create table(:files_users, primary_key: false) do
      add :file_id, references(:files, type: :binary_id), null: false, primary_key: true
      add :user_id, references(:accounts, type: :binary_id), null: false, primary_key: true
    end

    create index(:files, [:owner_id])
    create index(:file_events, [:file_id])
  end
end
