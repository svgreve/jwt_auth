defmodule JwtAuth.Accounts do
  alias JwtAuth.Accounts.Users.Create, as: UsersCreate
  alias JwtAuth.Accounts.Users.Get, as: UsersGet

  defdelegate create_user(params), to: UsersCreate, as: :call
  defdelegate get_user_by_id(id), to: UsersGet, as: :by_id

end
