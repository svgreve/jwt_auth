defmodule JwtAuth.GithubApi.Client do
  use Tesla

  @base_url "https://api.github.com/users/"
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def user(url \\ @base_url, username) do
    case byte_size(username) do
      0 ->
        {:error, :bad_request}

      _ ->
        "#{url}#{username}/repos"
        |> get()
        |> handle_get()
    end
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Tesla.Env{status: 404, body: _body}}) do
    {:error, :not_found}
  end

  defp handle_get({:error, _reason}) do
    {:error, :internal_server_error}
  end
end
