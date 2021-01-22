defmodule ConsultantBoard.DataPuller.ConsultantSpreadsheetAPI do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://sheets.googleapis.com/v4/spreadsheets/"
  plug Tesla.Middleware.JSON

  @spec extract() :: {:ok, list} | {:error, atom}
  def extract() do
    with {:ok, id} <- Application.fetch_env(:consultant_board, :spreadsheet_id),
         {:ok, page} <- Application.fetch_env(:consultant_board, :spreadsheet_page_consultant),
         {:ok, key} <- Application.fetch_env(:consultant_board, :google_api_key) do
      case get("/#{id}/values/#{page}", headers: [{"Authorization", "Bearer " <> key}]) do
        {:ok, %{body: data}} -> values(data)
        _error -> {:error, :request_failed}
      end
    end
  end

  defp values(data) do
    if not is_nil(data["values"]) do
      {:ok, data["values"]}
    else
      {:error, :request_failed}
    end
  end
end
