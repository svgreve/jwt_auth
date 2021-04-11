defmodule JwtAuthWeb.UserView do
  use JwtAuthWeb, :view

  alias JwtAuth.Accounts.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created",
      user: user,
      token: token
    }
  end
end
