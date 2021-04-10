defmodule JwtAuthWeb.UserController do
  use JwtAuthWeb, :controller

  alias JwtAuth.Accounts
  alias JwtAuth.Accounts.User


  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
