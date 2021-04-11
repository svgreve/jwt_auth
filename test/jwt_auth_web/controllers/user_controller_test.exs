defmodule JwtAuthWeb.UserControllerTest do
  use JwtAuthWeb.ConnCase, async: true

  alias JwtAuth.Accounts
  alias JwtAuthWeb.Auth.Guardian
  alias JwtAuthWeb.UserController

  @signup_attrs %{
    password: "12345678"
  }
  @invalid_signup_attrs %{
    password: "1234567"
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "when a valid password is provided, creates the account and returns the user and token",
         %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @signup_attrs)
      # assert json_response(conn, 201)["message"] == "User created"
      assert %{"id" => id} = json_response(conn, 201)["user"]
      assert token = json_response(conn, 201)["token"]
    end

    test "when an invalid password is provided, returns an error", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), @invalid_signup_attrs)

      assert json_response(conn, 400)["message"] == %{
               "password" => ["should be at least 8 character(s)"]
             }
    end
  end

  describe "signin/2" do
    test "when the correct password is provided, returns the user", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@signup_attrs)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      attrs = %{
        id: user.id,
        password: "12345678"
      }

      conn = post(conn, Routes.user_path(conn, :signin), attrs)
      assert token = json_response(conn, 200)["token"]
    end

    test "when an incorrect password is provided, returns an error", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@signup_attrs)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      attrs = %{
        id: user.id,
        password: "1234567x"
      }

      conn = post(conn, Routes.user_path(conn, :signin), attrs)
      assert "Please, check your credentials." = json_response(conn, 401)["message"]
    end
    test "when the user is invalid, returns an error", %{conn: conn} do
      attrs = %{
        id: "facecfa7-76b1-4d84-bba7-1e13a65c42d9",
        password: ""
      }

      conn = post(conn, Routes.user_path(conn, :signin), attrs)
      assert "User not found" = json_response(conn, 404)["message"]
    end
    test "when the password is missing, return an error", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@signup_attrs)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      attrs = %{
        id: user.id
      }

      conn = post(conn, Routes.user_path(conn, :signin), attrs)
      assert "Invalid or missing credentials." = json_response(conn, 400)["message"]
    end
  end
end
