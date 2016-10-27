defmodule Codetogether.ErrorView do
  use Codetogether.Web, :view

  def render("errors.json", %{errors: errors}) when is_map(errors) do
    %{errors: errors}
  end

  def render("errors.json", %{errors: errors}) when is_list(errors) do
    errors = Enum.reduce(errors, %{}, fn {field, message}, acc ->
      message = translate_error(message)
      Map.update(acc, field, [message], &[message | &1])
    end)
    render("errors.json", %{errors: errors})
  end

  def render("errors.json", %{changeset: changeset}) do
    errors = Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    render("errors.json", %{errors: errors})
  end

  def render("404.json", _assigns) do
    %{error: "Page not found"}
  end

  def render("500.json", _assigns) do
    %{error: "Internal server error"}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
  end
end
