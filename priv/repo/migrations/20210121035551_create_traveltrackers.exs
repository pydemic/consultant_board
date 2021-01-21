defmodule ConsultantBoard.Repo.Migrations.CreateTraveltrackers do
  use Ecto.Migration

  def change do
    create table(:traveltrackers) do
      add :name, :string
      add :name_unaccent, :string
      add :unit, :string
      add :start_date, :string
      add :end_date, :string
      add :home_country, :string
      add :home_federative_unit, :string
      add :home_city, :string
      add :destination_country, :string
      add :destination_federative_unit, :string
      add :destination_city, :string
      add :visited_cities, :string
      add :goal, :string
      add :days_away, :string

      timestamps()
    end

  end
end
