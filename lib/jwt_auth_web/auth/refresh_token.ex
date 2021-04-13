defmodule JwtAuthWeb.Auth.RefreshToken do
  import Plug.Conn

  alias JwtAuthWeb.Auth.Guardian

  def init(default), do: default

  def call(%Plug.Conn{} = conn, _default) do
    headers = conn.req_headers

    {"authorization", bearer} =
      Enum.find(headers, fn {k, v} -> if k == "authorization", do: v end)

    token = String.replace_leading(bearer, "Bearer ", "")

    {:ok, _old_stuff, {new_token, _new_claims}} = Guardian.refresh(token)

    assign(conn, :guardian_default_token, new_token)
  end
end
