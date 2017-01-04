defmodule Codetogether.File.User do
  use Codetogether.Schema

  alias Codetogether.{File, User}

  @primary_key false
  @foreign_key_type :binary_id

  schema "files_users" do
    belongs_to :file, File.Data, primary_key: true
    belongs_to :user, User.Account, primary_key: true
  end
end
