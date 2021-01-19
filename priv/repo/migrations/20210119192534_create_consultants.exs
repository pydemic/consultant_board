defmodule ConsultantBoard.Repo.Migrations.CreateConsultants do
  use Ecto.Migration

  def change do
    create table(:consultants) do
      add :city, :string
      add :contract_start_date, :string
      add :contract_type, :string
      add :direct_support, :string
      add :email, :string
      add :expected_contract_end_date, :string
      add :federative_unit, :string
      add :graduation_course, :string
      add :graduadion_degree, :string
      add :function, :string
      add :institution, :string
      add :name, :string
      add :phone, :string
      add :term, :string

      timestamps()
    end

  end
end
