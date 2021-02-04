defmodule ConsultantBoard.DataPuller.TravelTrackerSpreadsheetAPI do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://sheets.googleapis.com/v4/spreadsheets/"
  plug Tesla.Middleware.JSON

  @spec extract() :: {:ok, list} | {:error, atom}
  def extract() do
    with {:ok, token} <- Application.fetch_env(:consultant_board, :api_key),
         {:ok, id} <- Application.fetch_env(:consultant_board, :spreadsheet_id),
         {:ok, page} <- Application.fetch_env(:consultant_board, :spreadsheet_page_travel_tracker) do
      case get(URI.encode("/#{id}/values/#{page}"),
             headers: [{"Authorization", "Bearer " <> token}]
           ) do
        {:ok, %{body: data}} -> values(data)
        _error -> {:error, :request_failed}
      end
    end
  end

  defp values(data) when is_map(data) do
    if not is_nil(Map.get(data, "values", nil)) do
      {:ok, data["values"]}
    else
      {:error, :request_failed}
    end
  end

  defp values(_data) do
    {:error, :request_failed}
  end
end
