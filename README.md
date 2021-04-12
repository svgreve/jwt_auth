# JwtAuth

A aplicação possui dois contextos: 

- accounts
- github api 

As rotas principais são:

```
user_path   POST  /api/accounts/signup          JwtAuthWeb.UserController :create
user_path   POST  /api/accounts/signin          JwtAuthWeb.UserController :signin
user_path   GET   /api/accounts/:id             JwtAuthWeb.UserController :get
github_path GET   /api/github/:username         JwtAuthWeb.GithubController :get_repos
```

As rotas protegidas pelo Guardian são user_path => get e github_path => get_repos

## Desafio Ignite

Nesse desafio, você irá implementar uma nova feature para a aplicação desenvolvida no desafio [Consumindo APIs](https://www.notion.so/Desafio-01-Consumindo-APIs-59b66c4fc14147ff82a6e73b9ce23e85).
A aplicação deve possuir uma entidade `User` onde cada usuário possuirá apenas um id e senha. Ao fazer uma requisição para a rota de criação de usuários, deve ser enviado apenas a senha a ser cadastrada para o novo usuário, já o id deverá ser gerado pelo servidor e retornado no corpo da resposta.

Lembre-se de salvar o hash da senha no banco, não a senha "pura".

Para realizar a autenticação, deve ser enviado no corpo da requisição o id e senha e o retorno dessa chamada, em caso de sucesso, deverá possuir o token JWT gerado, exemplo:

```elixir
# Rota post /users/login

# Corpo da requisição
{id: "d4f0e64b-cc3f-4c09-b64d-ef450883e4e5", senha: "123456"}

# Resposta da chamada
{token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJCYW5hbmEiLCJuYW1lIjoiQmFuYW5hIiwiaWF0IjoxNTE2MjM5MDIyfQ.82aOexgMqejDxJzZzoBmVB_fPLiKRXe1rFEfoPl1sDs"}
```

Você pode usar a biblioteca Guardian para trabalhar com autenticação JWT: [https://github.com/ueberauth/guardian](https://github.com/ueberauth/guardian)

Ao chamar a rota que lista os repositórios de um usuário, será necessário enviar também o token JWT de um usuário que se autenticou na aplicação. Ou seja, apenas usuários cadastrados na aplicação podem fazer a listagem de repositórios.

---

Para enviar o desafio, você pode implementar a feature no mesmo repositório do desafio **Consumindo APIs** e enviar o link com o código atualizado sem a necessidade de criar um novo repositório.


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
