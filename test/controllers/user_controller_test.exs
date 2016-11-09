defmodule Codetogether.UserControllerTest do
  use Codetogether.ConnCase

  setup :with_user

  describe "show" do
    @tag :login
    test "responds with user data when logged in", %{conn: conn, user: user} do
      conn = get(conn, user_path(conn, :show))
      assert %{"user" => resp} = json_response(conn, :ok)
      assert resp["name"] == user.name
    end

    test "responds with unauthorized when not authenticated", %{conn: conn} do
      conn = get(conn, user_path(conn, :show))
      assert %{"error" => "Unauthenticated"} == json_response(conn, :unauthorized)
    end
  end

  defp with_user(%{login: true, conn: conn}) do
    user = insert(:user)
    conn = authenticate(conn, user)
    {:ok, user: user, conn: conn}
  end

  defp with_user(_), do: :ok
end
