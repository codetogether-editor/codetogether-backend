defmodule Codetogether.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      @timestamp_opts [type: :utc_datetime]
    end
  end
end
