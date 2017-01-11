defmodule Codetogether.File.Event do
  use Codetogether.Schema

  alias Codetogether.{File, User}

  schema "file_events" do
    field :data, :map

    belongs_to :file, File.Data, type: :binary_id
    belongs_to :user, User.Account, type: :binary_id
  end
end
