defmodule Conference do
  defstruct [:conference_key, :call_sid, :number]

  alias Commanded.Aggregate.Multi

  def execute(%Conference{conference_key: nil, call_sid: nil, number: nil} = conference,
    %CreateConference{conference_key: conference_key, call_sid: call_sid, number: number, username: username}) do
    conference
    |> Multi.new()
    |> Multi.execute(&create_conference(&1, conference_key, number))
    |> Multi.execute(&request_consultant_leg(&1, username))
  end

  def execute(%Conference{call_sid: nil} = conference, %UpdateLegStatus{conference_key: conference_key, call_sid: call_sid}) do
    conference
    |> Multi.new()
    |> Multi.execute(&connect_consultant_leg(&1, call_sid))
    |> Multi.execute(&request_customer_leg(&1))
  end

  def execute(%Conference{} = conference, %UpdateLegStatus{conference_key: conference_key, call_sid: call_sid}) do
      conference
      |> Multi.new()
      |> Multi.execute(&connect_customer_leg(&1, call_sid))
      |> Multi.execute(&start_conference(&1))
  end

  def execute(%Conference{} = conference, %EndConference{}) do
    end_conference(conference)
  end

  def execute(%Conference{} = conference, %HangUp{}) do
    hang_up(conference)
  end

  defp hang_up(%Conference{call_sid: call_sid, conference_key: conference_key}) do
    %ConsultantHangUpRequested{call_sid: call_sid, conference_key: conference_key}
  end

  defp create_conference(%Conference{}, conference_key, number) do
    %ConferenceCreated{conference_key: conference_key, number: number}
  end

  defp request_consultant_leg(%Conference{conference_key: conference_key}, username) do
    %ConsultantLegRequested{conference_key: conference_key, to: "client:" <> username}
  end

  defp connect_consultant_leg(%Conference{conference_key: conference_key}, call_sid) do
    %ConsultantLegConnected{conference_key: conference_key, call_sid: call_sid}
  end

  defp request_customer_leg(%Conference{conference_key: conference_key, number: number}) do
    %CustomerLegRequested{conference_key: conference_key, to: number}
  end

  defp connect_customer_leg(%Conference{conference_key: conference_key}, call_sid) do
    %CustomerLegConnected{conference_key: conference_key, call_sid: call_sid}
  end

  defp start_conference(%Conference{conference_key: conference_key}) do
    %ConferenceStarted{conference_key: conference_key}
  end

  defp end_conference(%Conference{conference_key: conference_key}) do
    %ConferenceEnded{conference_key: conference_key}
  end

  def apply(%Conference{} = conference, %ConsultantLegConnected{call_sid: call_sid}) do
    %Conference{conference | call_sid: call_sid }
  end

  def apply(%Conference{} = conference, %ConferenceCreated{conference_key: conference_key, number: number}) do
    %Conference{conference |
      conference_key: conference_key,
      number: number
    }
  end

  def apply(%Conference{} = conference, _) do
    conference
  end
end
