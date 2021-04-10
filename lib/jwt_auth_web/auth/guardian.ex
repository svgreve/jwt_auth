defmodule JwtAuthWeb.Guardian do
  use Guardian, otp_app: :jwt_auth

  alias JwtAuth.Accounts.User
  alias JwtAuth.Accounts.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end
end
