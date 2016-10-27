defmodule Codetogether.User.Account do
  use Codetogether.Schema

  alias Codetogether.User

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :name,       :string
    field :email,      :string
    field :avatar_url, :string

    has_many :authentications, User.Authentication
    field    :current_authentication, :map, virtual: true

    timestamps()
  end

  def changeset(schema, params \\ %{}) do
    schema
    |> cast(params, ~w(name avatar_url)a)
    |> validate_required(~w(name avatar_url)a)
  end
end
