defmodule JwtAuthWeb.Auth.RefreshToken do
  import Plug.Conn

  alias JwtAuthWeb.Auth.Guardian
  alias Plug.Conn

  @ttl_minutes 5

  def init(default), do: default

  # def call(%Conn{} = conn, _default) do
  #   "Bearer " <> token = Conn.get_req_header(conn, :authorization)
  #   {:ok, _old_stuff, {new_token, _new_claims}} = Guardian.refresh(token, ttl: {1, :minute})
  #   conn |> put_private(:token, new_token)
  #   conn
  # end

  def call(%Conn{} = conn, _default) do
    authorization = Conn.get_req_header(conn, "authorization")
    IO.inspect authorization
    ["Bearer " <> token] = authorization
    {:ok, _old_stuff, {new_token, _new_claims}} = Guardian.refresh(token, ttl: {@ttl_minutes, :minute})
    conn |> put_private(:token, new_token)
  end
end
