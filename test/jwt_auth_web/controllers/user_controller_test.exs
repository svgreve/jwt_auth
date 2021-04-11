defmodule JwtAuthWeb.UserControllerTest do
  use JwtAuthWeb.ConnCase, async: true

  alias JwtAuthWeb.UserController

  @signup_attrs %{
    password: "12345678"
  }
  @invalid_signup_attrs %{
    password: "1234567"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accecpt", "application/json")}
  end

  describe "create/2" do
    test "when an valid password is provided, returns the user and token", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @signup_attrs)
      assert json_response(conn, 201)["message"] == "User created"
    end

    test "when an invalid password is provided, returns an error", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @invalid_signup_attrs)
      assert json_response(conn, 400)["message"] == %{"password" => ["should be at least 8 character(s)"]}
    end
  end
end
