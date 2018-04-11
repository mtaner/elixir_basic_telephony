defmodule CustomerLegRequestedHandler do
  use Commanded.Event.Handler, name: "CustomerLegRequestedHandler"

  def handle(%CustomerLegRequested{conference_key: conference_key, to: to}, _metadata) do
    ExTwilio.Call.create(
      to: to,
      from: "+447480820334",
      url: "https://handler.twilio.com/twiml/EHfa3ebc25e3cebb81adab17c9044f566c?conference_uuid=" <> conference_key,
      status_callback: "https://merve-elixir.eu.ngrok.io/commands/status_callback?conference_uuid=" <> conference_key,
      status_callback_event: ["answered", "completed"]
    )
    :ok
  end
end
