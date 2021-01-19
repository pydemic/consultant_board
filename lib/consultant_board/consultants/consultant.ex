defmodule ConsultantBoard.Consultants.Consultant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consultants" do
    field :city, :string
    field :contract_start_date, :string
    field :contract_type, :string
    field :direct_support, :string
    field :email, :string
    field :expected_contract_end_date, :string
    field :federative_unit, :string
    field :function, :string
    field :graduadion_degree, :string
    field :graduation_course, :string
    field :institution, :string
    field :name, :string
    field :phone, :string
    field :term, :string

    timestamps()
  end

  @doc false
  def changeset(consultant, attrs) do
    consultant
    |> cast(attrs, [:city, :contract_start_date, :contract_type, :direct_support, :email, :expected_contract_end_date, :federative_unit, :graduation_course, :graduadion_degree, :function, :institution, :name, :phone, :term])
    |> validate_required([:city, :contract_start_date, :contract_type, :direct_support, :email, :expected_contract_end_date, :federative_unit, :graduation_course, :graduadion_degree, :function, :institution, :name, :phone, :term])
  end
end
