defmodule Codetogether.FileView do
  use Codetogether.Web, :view

  def render("show.json", %{data: file}) do
    %{file: render_one(file, __MODULE__, "file.json")}
  end

  def render("file.json", %{file: file}) do
    %{id:     file.id,
      name:   file.name,
      events: Enum.map(file.events, &(&1.data))}
  end
end
