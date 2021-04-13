defmodule JwtAuthWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :jwt_auth

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug JwtAuthWeb.Auth.RefreshToken

end
