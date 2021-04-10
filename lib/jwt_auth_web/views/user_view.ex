defmodule JwtAuthWeb.UserView do
  use JwtAuthWeb, :view

  alias JwtAuth.Accounts.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User created",
      user: user
    }
  end
end
