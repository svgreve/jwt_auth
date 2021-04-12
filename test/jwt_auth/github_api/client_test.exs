defmodule JwtAuth.GithubApi.ClientTest do
  use ExUnit.Case, async: true

  alias JwtAuth.GithubApi.Client

  describe "user/2" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "when the username is valid, returns user info", %{bypass: bypass} do
      username = "svgreve"

      url = endpoint_url(bypass.port)

      body = ~s({"a": "b"})

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = Client.user(url, username)
      expected_response = {:ok, %{"a" => "b"}}

      assert response == expected_response
    end

    test "when the username is not found, returns an error", %{bypass: bypass} do
      username = "sergiogreve"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        Plug.Conn.resp(conn, 404, "")
      end)

      response = Client.user(url, username)
      expected_response =  {:error, :not_found}

      assert response == expected_response
    end

    test "when there is a generic error, returns an error", %{bypass: bypass} do
      username = "sergiogreve"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.user(url, username)
      expected_response =  {:error, :internal_server_error}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
