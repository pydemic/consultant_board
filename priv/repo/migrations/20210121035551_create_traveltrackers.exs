defmodule ConsultantBoard.Repo.Migrations.CreateTraveltrackers do
  use Ecto.Migration

  def change do
    create table(:traveltrackers) do

      add :datetime_record, :string
      add :name, :string
      add :name_unaccent, :string
      add :unit, :string
      add :travel_type, :string
      add :start_date, :string
      add :end_date, :string
      add :goal, :string
      add :home_federative_unit, :string
      add :home_city, :string
      add :destination_federative_unit, :string
      add :destination_city, :string
      add :visited_cities, :string
      add :home_country, :string
      add :destination_country, :string
      add :visited_cities_international, :string

      timestamps()
    end

  end
end
