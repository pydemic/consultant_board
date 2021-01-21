defmodule ConsultantBoard.DataPuller.TravelTrackerSpreadsheetAPI do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://sheets.googleapis.com/v4/spreadsheets/"
  plug Tesla.Middleware.JSON

  @spec extract() :: {:ok, map} | {:error, atom}
  def extract() do
    with {:ok, id} <- Application.fetch_env(:consultant_board, :spreadsheet_id),
         {:ok, page} <- Application.fetch_env(:consultant_board, :spreadsheet_page_travel_tracker),
         {:ok, key} <- Application.fetch_env(:consultant_board, :google_api_key) do
      case get(IO.inspect("/#{id}/values/#{page}"), headers: [{"Authorization", "Bearer " <> key}])  do
        {:ok, %{body: data}} -> {:ok, data["values"]}
        _error -> {:error, :request_failed}
      end
    end
  end
end
