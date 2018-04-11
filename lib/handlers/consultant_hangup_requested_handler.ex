defmodule ConsultantHangUpRequestedHandler do
  use Commanded.Event.Handler, name: "ConsultantHangUpRequestedHandler"

  def handle(%ConsultantHangUpRequested{call_sid: call_sid}, _metadata) do
    ExTwilio.Call.update(call_sid, status: "completed")
    :ok
  end
end
