defmodule TwilioSandbox.PageController do
  use TwilioSandbox.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def status_callback(conn, params) do
    case params["CallStatus"] do
      "in-progress" ->
          ConferenceRouter.dispatch(%UpdateLegStatus{call_sid: params["CallSid"], conference_key: params["conference_uuid"]})
      "completed" ->
          ConferenceRouter.dispatch(%EndConference{conference_key: params["conference_uuid"]})
      _ -> IO.puts params["CallStatus"]
    end

    json(conn, %{status: 200})
  end

  def token(conn, params) do
    token =
      ExTwilio.Capability.new()
      |> ExTwilio.Capability.allow_client_incoming(params["username"])
      |> ExTwilio.Capability.token()

    json(conn, %{token: token})
  end
end
