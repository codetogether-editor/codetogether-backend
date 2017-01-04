defmodule Codetogether.FileView do
  use Codetogether.Web, :view

  def render("show.json", %{data: file}) do
    %{file: render_one(file, __MODULE__, "file.json")}
  end

  def render("file.json", %{file: file}) do
    %{id:     file.id,
      name:   file.name,
      users:  Enum.map(file.users, &(&1.user_id))}
  end
end
