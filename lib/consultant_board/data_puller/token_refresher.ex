defmodule ConsultantBoard.DataPuller.TokenRefresher do
  use Tesla, only: [:post]

  plug Tesla.Middleware.BaseUrl, "https://oauth2.googleapis.com"
  plug Tesla.Middleware.JSON

  @spec refresh(String.t(), String.t(), String.t()) :: {:ok, String.t()} | {:error, atom}
  def refresh(client_id, client_secret, refresh_token) do
    now = DateTime.utc_now()

    case post("/token", refresh_payload(client_id, client_secret, refresh_token)) do
      {:ok, %{status: 200, body: body}} -> format_body(body, now)
      {:ok, %{status: 401}} -> {:error, :unauthorized}
      {:ok, _response} -> {:error, :unknown_response}
      {:error, _reason} -> {:error, :request_failed}
    end
  end

  defp refresh_payload(client_id, client_secret, refresh_token) do
    %{
      client_id: client_id,
      client_secret: client_secret,
      refresh_token: refresh_token,
      grant_type: "refresh_token"
    }
  end

  defp format_body(body, now) do
    case body do
      %{"access_token" => access_token, "expires_in" => expires_in} ->
        %{access_token: access_token, expires_at: DateTime.add(now, expires_in)}

      _body ->
        {:error, :body_invalid}
    end
  end
end
