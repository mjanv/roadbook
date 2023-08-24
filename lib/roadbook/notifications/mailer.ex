defmodule Roadbook.Notifications.Mailer do
  @moduledoc false

  use Swoosh.Mailer, otp_app: :roadbook

  import Swoosh.Email

  def send(recipient, subject, body) do
    email =
      new()
      |> to(recipient)
      |> from({"Roadbook", "contact@example.com"})
      |> subject(subject)
      |> text_body(body)

    with {:ok, _metadata} <- __MODULE__.deliver(email) do
      {:ok, email}
    end
  end
end
