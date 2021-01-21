defmodule ConsultantBoard.DataPuller.ConsultantSpreadsheetAPI do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://sheets.googleapis.com/v4/spreadsheets/"
  plug Tesla.Middleware.JSON

  @spec extract() :: {:ok, map} | {:error, atom}
  def extract() do
    with {:ok, id} <- Application.fetch_env(:consultant_board, :spreadsheet_id),
         {:ok, page} <- Application.fetch_env(:consultant_board, :spreadsheet_page_consultant),
         {:ok, key} <- Application.fetch_env(:consultant_board, :google_api_key) do
      case get("/#{id}/values/#{page}?key=#{key}") do
        {:ok, %{body: data}} -> {:ok, data["values"]}
        _error -> {:error, :request_failed}
      end
    end
  end
end
