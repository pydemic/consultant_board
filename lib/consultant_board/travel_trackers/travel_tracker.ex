defmodule ConsultantBoard.TravelTrackers.TravelTracker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "traveltrackers" do
    field :datetime_record, :string
    field :name, :string
    field :name_unaccent, :string
    field :unit, :string
    field :travel_type, :string
    field :start_date, :string
    field :end_date, :string
    field :goal, :string
    field :home_federative_unit, :string
    field :home_city, :string
    field :destination_federative_unit, :string
    field :destination_city, :string
    field :visited_cities, :string
    field :home_country, :string
    field :destination_country, :string
    field :visited_cities_international, :string

    timestamps()
  end

  @doc false
  def changeset(travel_tracker, attrs) do
    travel_tracker
    |> cast(attrs, [
      :datetime_record,
      :name,
      :name_unaccent,
      :unit,
      :travel_type,
      :start_date,
      :end_date,
      :goal,
      :home_federative_unit,
      :home_city,
      :destination_federative_unit,
      :destination_city,
      :visited_cities,
      :home_country,
      :destination_country,
      :visited_cities_international
    ])
    |> validate_required([
      :datetime_record,
      :name,
      :name_unaccent,
      :unit,
      :travel_type,
      :start_date,
      :end_date,
      :goal,
      :home_federative_unit,
      :home_city,
      :destination_federative_unit,
      :destination_city,
      :visited_cities,
      :home_country,
      :destination_country,
      :visited_cities_international
    ])
  end
end
