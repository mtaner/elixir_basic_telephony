defmodule TwilioSandbox.CommandsController do
  use TwilioSandbox.Web, :controller

  def dial(conn, params) do
    ConferenceRouter.dispatch(%CreateConference{conference_key: Integer.to_string(params["conference_key"]), call_sid: nil, number: params["phone_number"], username: params["username"]})

    json(conn, %{})
  end

  def hangup(conn, params) do
    ConferenceRouter.dispatch(%HangUp{call_sid: params["call_sid"], conference_key: Integer.to_string(params["conference_key"])})

    json(conn, %{})
  end
end
