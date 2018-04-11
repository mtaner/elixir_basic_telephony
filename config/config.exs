# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sandbox_twilio,
  namespace: TwilioSandbox,
  ecto_repos: [TwilioSandbox.Repo]

# Configures the endpoint
config :sandbox_twilio, TwilioSandbox.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "CDVI4TM9KOY+g4FHztD//2D8ybsXiSV7QVAUgFRw9UFQ+9x8RjVz0lGonzygwc6f",
  render_errors: [view: TwilioSandbox.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TwilioSandbox.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :commanded, event_store_adapter: Commanded.EventStore.Adapters.EventStore

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
