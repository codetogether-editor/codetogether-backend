defmodule Codetogether.File.Data do
  use Codetogether.Schema

  alias Codetogether.{User, File}

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "files" do
    field :name, :string

    belongs_to :owner,  User.Account, type: :binary_id
    has_many   :events, File.Event, foreign_key: :file_id
    has_many   :users,  File.User,  foreign_key: :file_id

    timestamps()
  end

  def changeset(schema, params \\ %{}) do
    schema
    |> cast(params, ~w(name)a)
    |> validate_required(~w(name)a)
  end
end
