defmodule ConferenceRouter do
  use Commanded.Commands.Router

  dispatch CreateConference, to: Conference, identity: :conference_key
  dispatch UpdateLegStatus, to: Conference, identity: :conference_key
  dispatch EndConference, to: Conference, identity: :conference_key
  dispatch HangUp, to: Conference, identity: :conference_key
end
