defmodule JwtAuthWeb.GithubController do
  use JwtAuthWeb, :controller

  action_fallback FallbackController

  def get_repos(conn, %{"username" => username}) do
    with {:ok, repos} <- JwtAuth.GithubApi.user_repos(username) do
      render(conn, "repos.json", %{repos: repos, token: conn.private.token})
    end
  end
end
