defmodule Codetogether.FileControllerTest do
  use Codetogether.ConnCase

  setup :with_user

  describe "create" do
    @tag :login
    test "creates file when logged in", %{conn: conn} do
      conn = post(conn, file_path(conn, :create))
      assert %{"file" => resp} = json_response(conn, :created)
      assert resp["id"]
    end

    test "responds with unauthorized when not authenticated", %{conn: conn} do
      conn = post(conn, file_path(conn, :create))
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
