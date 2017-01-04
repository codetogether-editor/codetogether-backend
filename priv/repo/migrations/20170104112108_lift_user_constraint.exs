defmodule Codetogether.Repo.Migrations.LiftUserConstraint do
  use Ecto.Migration

  def change do
    alter table(:accounts) do
      modify :name, :string, null: true
    end
  end
end
