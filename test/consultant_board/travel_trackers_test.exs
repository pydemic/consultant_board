defmodule ConsultantBoard.TravelTrackersTest do
  use ConsultantBoard.DataCase

  alias ConsultantBoard.TravelTrackers

  describe "traveltrackers" do
    alias ConsultantBoard.TravelTrackers.TravelTracker

    @valid_attrs %{days_away: "some days_away", destination_city: "some destination_city", destination_country: "some destination_country", destination_federative_unit: "some destination_federative_unit", end_date: "some end_date", goal: "some goal", home_city: "some home_city", home_country: "some home_country", home_federative_unit: "some home_federative_unit", name: "some name", start_date: "some start_date", unit: "some unit", visited_cities: "some visited_cities"}
    @update_attrs %{days_away: "some updated days_away", destination_city: "some updated destination_city", destination_country: "some updated destination_country", destination_federative_unit: "some updated destination_federative_unit", end_date: "some updated end_date", goal: "some updated goal", home_city: "some updated home_city", home_country: "some updated home_country", home_federative_unit: "some updated home_federative_unit", name: "some updated name", start_date: "some updated start_date", unit: "some updated unit", visited_cities: "some updated visited_cities"}
    @invalid_attrs %{days_away: nil, destination_city: nil, destination_country: nil, destination_federative_unit: nil, end_date: nil, goal: nil, home_city: nil, home_country: nil, home_federative_unit: nil, name: nil, start_date: nil, unit: nil, visited_cities: nil}

    def travel_tracker_fixture(attrs \\ %{}) do
      {:ok, travel_tracker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TravelTrackers.create_travel_tracker()

      travel_tracker
    end

    test "list_traveltrackers/0 returns all traveltrackers" do
      travel_tracker = travel_tracker_fixture()
      assert TravelTrackers.list_traveltrackers() == [travel_tracker]
    end

    test "get_travel_tracker!/1 returns the travel_tracker with given id" do
      travel_tracker = travel_tracker_fixture()
      assert TravelTrackers.get_travel_tracker!(travel_tracker.id) == travel_tracker
    end

    test "create_travel_tracker/1 with valid data creates a travel_tracker" do
      assert {:ok, %TravelTracker{} = travel_tracker} = TravelTrackers.create_travel_tracker(@valid_attrs)
      assert travel_tracker.days_away == "some days_away"
      assert travel_tracker.destination_city == "some destination_city"
      assert travel_tracker.destination_country == "some destination_country"
      assert travel_tracker.destination_federative_unit == "some destination_federative_unit"
      assert travel_tracker.end_date == "some end_date"
      assert travel_tracker.goal == "some goal"
      assert travel_tracker.home_city == "some home_city"
      assert travel_tracker.home_country == "some home_country"
      assert travel_tracker.home_federative_unit == "some home_federative_unit"
      assert travel_tracker.name == "some name"
      assert travel_tracker.start_date == "some start_date"
      assert travel_tracker.unit == "some unit"
      assert travel_tracker.visited_cities == "some visited_cities"
    end

    test "create_travel_tracker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TravelTrackers.create_travel_tracker(@invalid_attrs)
    end

    test "update_travel_tracker/2 with valid data updates the travel_tracker" do
      travel_tracker = travel_tracker_fixture()
      assert {:ok, %TravelTracker{} = travel_tracker} = TravelTrackers.update_travel_tracker(travel_tracker, @update_attrs)
      assert travel_tracker.days_away == "some updated days_away"
      assert travel_tracker.destination_city == "some updated destination_city"
      assert travel_tracker.destination_country == "some updated destination_country"
      assert travel_tracker.destination_federative_unit == "some updated destination_federative_unit"
      assert travel_tracker.end_date == "some updated end_date"
      assert travel_tracker.goal == "some updated goal"
      assert travel_tracker.home_city == "some updated home_city"
      assert travel_tracker.home_country == "some updated home_country"
      assert travel_tracker.home_federative_unit == "some updated home_federative_unit"
      assert travel_tracker.name == "some updated name"
      assert travel_tracker.start_date == "some updated start_date"
      assert travel_tracker.unit == "some updated unit"
      assert travel_tracker.visited_cities == "some updated visited_cities"
    end

    test "update_travel_tracker/2 with invalid data returns error changeset" do
      travel_tracker = travel_tracker_fixture()
      assert {:error, %Ecto.Changeset{}} = TravelTrackers.update_travel_tracker(travel_tracker, @invalid_attrs)
      assert travel_tracker == TravelTrackers.get_travel_tracker!(travel_tracker.id)
    end

    test "delete_travel_tracker/1 deletes the travel_tracker" do
      travel_tracker = travel_tracker_fixture()
      assert {:ok, %TravelTracker{}} = TravelTrackers.delete_travel_tracker(travel_tracker)
      assert_raise Ecto.NoResultsError, fn -> TravelTrackers.get_travel_tracker!(travel_tracker.id) end
    end

    test "change_travel_tracker/1 returns a travel_tracker changeset" do
      travel_tracker = travel_tracker_fixture()
      assert %Ecto.Changeset{} = TravelTrackers.change_travel_tracker(travel_tracker)
    end
  end
end
