defmodule ConsultantBoard.DataPuller.Seeder do
  alias ConsultantBoard.Consultants.Consultant
  alias ConsultantBoard.DataPuller.ConsultantSpreadsheetAPI
  alias ConsultantBoard.DataPuller.TravelTrackerSpreadsheetAPI
  alias ConsultantBoard.TravelTrackers.TravelTracker
  alias ConsultantBoard.DataPuller.TokenRefresher
  alias ConsultantBoard.Repo

  require Logger

  @spec seeder :: :error | :ok
  def seeder do
    with {:ok, client_id} <- Application.fetch_env(:consultant_board, :google_api_client_id),
         {:ok, client_secret} <-
           Application.fetch_env(:consultant_board, :google_api_client_secret),
         {:ok, refresh_token} <-
           Application.fetch_env(:consultant_board, :google_api_refresh_token) do
      Logger.info("Fetching token")

      case TokenRefresher.refresh(client_id, client_secret, refresh_token) do
        {:ok, %{access_token: access_token}} ->
          seed_data(access_token)

        {:error, error} ->
          Logger.error("Failed to get refreshed token. Reason: #{inspect(error)}")
          :error
      end
    end
  end

  defp seed_data(token) do
    case [extract_and_seed_consultant(token), extract_and_seed_travel_tracker(token)] do
      [:ok, :ok] -> :ok
      _ -> :error
    end
  end

  defp extract_and_seed_consultant(token) do
    Logger.info("Fetching Consultant data")

    case ConsultantSpreadsheetAPI.extract(token) do
      {:ok, [_header | consultant_spreadsheet_data]} ->
        Repo.delete_all(Consultant)
        seed_consultant(consultant_spreadsheet_data)

      {:error, error} ->
        Logger.error("Failed to fetch Consultant data. Reason: #{inspect(error)}")
        {:error, error}
    end
  end

  defp extract_and_seed_travel_tracker(token) do
    Logger.info("Fetching Travel Tracker data")

    case TravelTrackerSpreadsheetAPI.extract(token) do
      {:ok, [_header | travel_tracker_spreadsheet_data]} ->
        Repo.delete_all(TravelTracker)
        seed_travel_tracker(travel_tracker_spreadsheet_data)

      {:error, error} ->
        Logger.error("Failed to fetch TravelTracker data. Reason: #{inspect(error)}")
        {:error, error}
    end
  end

  defp seed_consultant(data) do
    Enum.each(
      data,
      fn line ->
        name = Enum.at(line, 0, "")
        name_unaccent = name |> String.normalize(:nfd) |> String.replace(~r/[^A-z\s]/u, "")
        contract_type = Enum.at(line, 1, "")
        term = Enum.at(line, 2, "")
        direct_support = Enum.at(line, 3, "")
        federative_unit = Enum.at(line, 4, "")
        city = Enum.at(line, 5, "")
        institution = Enum.at(line, 6, "")
        graduation_course = Enum.at(line, 7, "")
        function = Enum.at(line, 8, "")
        graduation_degree = Enum.at(line, 9, "")
        phone = Enum.at(line, 10, "")
        email = Enum.at(line, 11, "")
        contract_start_date = Enum.at(line, 12, "")
        expected_contract_end_date = Enum.at(line, 13, "")

        %Consultant{
          name: name,
          name_unaccent: name_unaccent,
          contract_type: contract_type,
          term: term,
          direct_support: direct_support,
          federative_unit: federative_unit,
          city: city,
          institution: institution,
          graduation_course: graduation_course,
          function: function,
          graduation_degree: graduation_degree,
          phone: phone,
          email: email,
          contract_start_date: contract_start_date,
          expected_contract_end_date: expected_contract_end_date
        }
        |> Repo.insert!()
      end
    )
  end

  defp seed_travel_tracker(data) do
    Enum.each(
      data,
      fn line ->
        datetime_record = Enum.at(line, 0, "")
        name = Enum.at(line, 1, "")
        name_unaccent = name |> String.normalize(:nfd) |> String.replace(~r/[^A-z\s]/u, "")
        unit = Enum.at(line, 2, "")
        travel_type = Enum.at(line, 3, "")
        start_date = Enum.at(line, 4, "")
        end_date = Enum.at(line, 5, "")
        goal = Enum.at(line, 6, "")
        home_federative_unit = Enum.at(line, 7, "")
        home_city = Enum.at(line, 8, "")
        destination_federative_unit = Enum.at(line, 9, "")
        destination_city = Enum.at(line, 10, "")
        visited_cities = Enum.at(line, 11, "")
        home_country = Enum.at(line, 12, "")
        destination_country = Enum.at(line, 13, "")
        visited_cities_international = Enum.at(line, 14, "")

        %TravelTracker{
          datetime_record: datetime_record,
          name: name,
          name_unaccent: name_unaccent,
          unit: unit,
          travel_type: travel_type,
          start_date: start_date,
          end_date: end_date,
          goal: goal,
          home_federative_unit: home_federative_unit,
          home_city: home_city,
          destination_federative_unit: destination_federative_unit,
          destination_city: destination_city,
          visited_cities: visited_cities,
          home_country: home_country,
          destination_country: destination_country,
          visited_cities_international: visited_cities_international
        }
        |> Repo.insert!()
      end
    )
  end
end
