defmodule JwtAuthWeb.Auth.Guardian do
  use Guardian, otp_app: :jwt_auth

  alias JwtAuth.Accounts.User
  alias JwtAuth.Accounts.Users.Get, as: UserGet
  alias JwtAuth.Error

  @ttl_minutes 5

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> UserGet.by_id()
  end

  def authenticate(%{"id" => id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(id),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user, %{}, ttl: {@ttl_minutes, :minute}) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please, check your credentials.")}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing credentials.")}
end
