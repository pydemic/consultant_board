defmodule ConsultantBoard.DataPuller.TokenRefresher do
  @spec refresh() :: {:ok, map()} | {:error, atom}
  def refresh() do
    case Goth.Token.for_scope("https://www.googleapis.com/auth/spreadsheets.readonly") do
      {:ok, token} -> {:ok, token}
      _ -> {:error, :request_token_failed}
    end
  end
end
