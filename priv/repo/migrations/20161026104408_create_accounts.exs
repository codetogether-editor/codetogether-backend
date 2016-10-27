defmodule Codetogether.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id,         :binary_id, primary_key: true
      add :name,       :string,    null: false
      add :email,      :string,    null: false
      add :avatar_url, :string,    null: false

      timestamps()
    end

    create table(:authentications, primary_key: false) do
      add :provider,      :string, null: false, primary_key: true
      add :uid,           :string, null: false, primary_key: true
      add :token,         :string, null: false
      add :refresh_token, :string
      add :expires_at,    :utc_datetime

      add :account_id, references(:accounts, type: :binary_id, on_delete: :delete_all), null: false

      timestamps()
    end
  end
end
