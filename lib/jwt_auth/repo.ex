defmodule JwtAuth.Repo do
  use Ecto.Repo,
    otp_app: :jwt_auth,
    adapter: Ecto.Adapters.Postgres
end
