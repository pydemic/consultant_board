defmodule ConsultantBoard.TravelTrackers.TravelTracker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "traveltrackers" do
    field :days_away, :string
    field :destination_city, :string
    field :destination_country, :string
    field :destination_federative_unit, :string
    field :end_date, :string
    field :goal, :string
    field :home_city, :string
    field :home_country, :string
    field :home_federative_unit, :string
    field :name, :string
    field :name_unaccent, :string
    field :start_date, :string
    field :unit, :string
    field :visited_cities, :string

    timestamps()
  end

  @doc false
  def changeset(travel_tracker, attrs) do
    travel_tracker
    |> cast(attrs, [
      :name,
      :name_unaccent,
      :unit,
      :start_date,
      :end_date,
      :home_country,
      :home_federative_unit,
      :home_city,
      :destination_country,
      :destination_federative_unit,
      :destination_city,
      :visited_cities,
      :goal,
      :days_away
    ])
    |> validate_required([
      :name,
      :name_unaccent,
      :unit,
      :start_date,
      :end_date,
      :home_country,
      :home_federative_unit,
      :home_city,
      :destination_country,
      :destination_federative_unit,
      :destination_city,
      :visited_cities,
      :goal,
      :days_away
    ])
  end
end
