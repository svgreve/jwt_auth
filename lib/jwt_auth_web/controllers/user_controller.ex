defmodule JwtAuthWeb.UserController do
  use JwtAuthWeb, :controller

  alias JwtAuth.Accounts
  alias JwtAuth.Accounts.User
  alias JwtAuthWeb.Auth.Guardian

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end
end
