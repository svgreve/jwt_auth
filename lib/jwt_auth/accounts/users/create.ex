defmodule JwtAuth.Accounts.Users.Create do
  alias JwtAuth.Repo
  alias JwtAuth.Accounts.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end

end
