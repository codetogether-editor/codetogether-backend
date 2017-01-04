defmodule Codetogether.UserView do
  use Codetogether.Web, :view

  def render("show.json", %{data: account}) do
    %{user: render_one(account, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: account}) do
    %{id:         account.id,
      name:       account.name,
      email:      account.email,
      avatar_url: account.avatar_url}
  end
end
