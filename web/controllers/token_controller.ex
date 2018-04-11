defmodule TwilioSandbox.TokenController do
  use TwilioSandbox.Web, :controller

  def token(conn, params) do
    token =
      ExTwilio.Capability.new()
      |> ExTwilio.Capability.allow_client_incoming(params["username"])
      |> ExTwilio.Capability.token()

    json(conn, %{token: token})
  end
end
