defmodule Codetogether.UserView do
  use Codetogether.Web, :view

  def render("show.json", %{data: account, files: files}) do
    %{user: render_one(account, __MODULE__, "me.json", files: files)}
  end

  def render("show.json", %{data: account}) do
    %{user: render_one(account, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: account}) do
    Map.take(account, ~w[id name email avatar_url]a)
  end

  def render("me.json", %{files: files} = assigns) do
    Map.merge(render("user.json", assigns), %{files: render_files(files)})
  end

  defp render_files(files), do: Enum.map(files, &render_file/1)

  defp render_file(file), do: Map.take(file, ~w[id name]a)
end
