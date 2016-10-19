defmodule Codetogether.PageController do
  use Codetogether.Web, :controller

  def index(conn, _params) do
    json(conn, %{hello: :world})
  end
end
