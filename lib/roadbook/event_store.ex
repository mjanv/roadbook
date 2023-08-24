defmodule Roadbook.EventStore do
  @moduledoc false

  alias EventStore.EventData

  use EventStore, otp_app: :roadbook, schema: "events"

  def init(config) do
    {:ok, config}
  end

  def read(stream_uuid) do
    {:ok, events} = __MODULE__.read_stream_forward(stream_uuid)
    Enum.map(events, fn %EventStore.RecordedEvent{data: event} -> event end)
  end

  def ok({:ok, data}, stream_uuid, f) do
    write(data, stream_uuid, f)
    {:ok, data}
  end

  def ok(pattern, _stream_uuid, _f), do: pattern

  def error({:error, reason}, stream_uuid, g) do
    write(reason, stream_uuid, g)
    {:error, reason}
  end

  def error(pattern, _stream_uuid, _g), do: pattern

  def ok_or({:ok, data}, stream_uuid, f, _g) do
    write(data, stream_uuid, f)
    {:ok, data}
  end

  def ok_or({:error, data}, stream_uuid, _f, g) do
    write(data, stream_uuid, g)
    {:error, data}
  end

  def write(data, stream_uuid, h) do
    case h.(data) do
      {event, metadata} ->
        event = %EventData{
          event_type: Atom.to_string(event.__struct__),
          data: event,
          metadata: metadata
        }

        :ok = __MODULE__.append_to_stream(stream_uuid, :any_version, [event])

      event ->
        event = %EventData{
          event_type: Atom.to_string(event.__struct__),
          data: event,
          metadata: %{}
        }

        :ok = __MODULE__.append_to_stream(stream_uuid, :any_version, [event])
    end
  end
end
