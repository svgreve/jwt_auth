defmodule JwtAuthWeb.GithubView do
  use JwtAuthWeb, :view

  def render("repos.json", %{repos: repos}), do: %{repos: repos}
end
