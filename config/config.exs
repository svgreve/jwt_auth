# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jwt_auth,
  ecto_repos: [JwtAuth.Repo]

config :jwt_auth, JwtAuth.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

config :jwt_auth, JwtAuthWeb.Auth.Guardian,
  issuer: "jwt_auth",
  secret_key: "091/cxKEpVJSUAhqIR4XNQkTxZKNW/8o1AOP7cPHJB2188RUeE/Q86pP2mcf8heK"

config :jwt_auth, JwtAuthWeb.Auth.Pipeline,
  module: JwtAuthWeb.Auth.Guardian,
  error_handler: JwtAuthWeb.Auth.ErrorHandler

# Configures the endpoint
config :jwt_auth, JwtAuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "s6uZpo0ggAYk+/KGgz8tFnKBv6Grgbi/95X2HkzbMsS56035u2WCzjqbwj+Y8nK7",
  render_errors: [view: JwtAuthWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: JwtAuth.PubSub,
  live_view: [signing_salt: "YzSP0hOg"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
