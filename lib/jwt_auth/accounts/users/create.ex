defmodule JwtAuth.Accounts.Users.Create do
  alias JwtAuth.Repo
  alias JwtAuth.Accounts.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, result})  do
    {:error, %{status: :bad_request, result: result}}
  end

end
