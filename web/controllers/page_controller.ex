defmodule Codetogether.PageController do
  use Codetogether.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
