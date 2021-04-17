defmodule JwtAuthWeb.GithubView do
  use JwtAuthWeb, :view

  def render("repos.json", %{repos: repos, token: token}) do
    %{repos: repos, token: token}
  end
end
