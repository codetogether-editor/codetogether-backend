defmodule Codetogether.User.Authentication do
  use Codetogether.Schema

  alias Codetogether.User

  @primary_key false

  schema "authentications" do
    field :provider,      :string, primary_key: true
    field :uid,           :string, primary_key: true
    field :token,         :string
    field :refresh_token, :string
    field :expires_at,    :utc_datetime

    belongs_to :account, User.Account, type: :binary_id

    timestamps()
  end
end
