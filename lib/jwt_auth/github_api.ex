defmodule JwtAuth.GithubApi do
  alias JwtAuth.GithubApi.Client

  def user_repos(username) do
    case Client.user(username) do
      {:ok, repos}  -> {:ok, parse_repos(repos)}
      {:error, status} -> {:error, %{status: status}}
    end
  end

  defp parse_repos(repos) do
    repos
    |> Enum.map(fn repo -> select_fields(repo) end)
  end


  defp select_fields(%{
         "id" => id,
         "description" => description,
         "html_url" => html_url,
         "name" => name,
         "stargazers_count" => stargazers_count
       }) do
    %{
      id: id,
      name: name,
      description: description,
      html_url: html_url,
      stargazers_count: stargazers_count
    }
  end
end
