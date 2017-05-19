# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :logitpho,
  ecto_repos: [Logitpho.Repo]

# Configures the endpoint
config :logitpho, Logitpho.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Bm5BOrrHLrbuQUHT39G+XSe0kCQtYdOTxRlhVOVmbxWgy96Jzr7Krn/CL4/6lYgi",
  render_errors: [view: Logitpho.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Logitpho.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Guardian
config :guardian, Guardian,
  issuer: "MyApp",
  ttl: { 30, :days },
  allowed_drift: 2000,
  secret_key: "!@#$%^&*()",
  serializer: Logitpho.GuardianSerializer
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
