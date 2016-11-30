defmodule Codetogether.File do
  def create(_user) do
    {:ok, %{id: Ecto.UUID.generate}}
  end
end
