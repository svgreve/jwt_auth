defmodule JwtAuth.Accounts do
  alias JwtAuth.Accounts.Users.Create, as: UsersCreate

  defdelegate create_user(params), to: UsersCreate, as: :call

end
