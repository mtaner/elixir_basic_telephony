use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# command from your terminal:
#
#     openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -keyout priv/server.key -out priv/server.pem
#
# The `http:` config below can be replaced with:
# https: [port: 4000, keyfile: "priv/server.key", certfile: "priv/server.pem"],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

config :sandbox_twilio, TwilioSandbox.Endpoint,
  http: [port: {:system, "PORT"}],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [yarn: ["start"]]

# Configure your database
config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  database: "eventstore_dev",
  hostname: "localhost",
  pool_size: 10

config :sandbox_twilio, TwilioSandbox.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  database: "sandbox_twilio_dev",
  hostname: "localhost",
  pool_size: 10

# Watch static and templates for browser reloading.
config :sandbox_twilio, TwilioSandbox.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :ex_twilio,
  account_sid: "ACCOUNT_SID",
  auth_token: "AUTH_TOKEN"

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

import_config "dev.secret.exs"
