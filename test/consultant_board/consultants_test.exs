defmodule ConsultantBoard.ConsultantsTest do
  use ConsultantBoard.DataCase

  alias ConsultantBoard.Consultants

  describe "consultants" do
    alias ConsultantBoard.Consultants.Consultant

    @valid_attrs %{city: "some city", contract_start_date: "some contract_start_date", contract_type: "some contract_type", direct_support: "some direct_support", email: "some email", expected_contract_end_date: "some expected_contract_end_date", federative_unit: "some federative_unit", function: "some function", graduadion_degree: "some graduadion_degree", graduation_course: "some graduation_course", institution: "some institution", name: "some name", phone: "some phone", term: "some term"}
    @update_attrs %{city: "some updated city", contract_start_date: "some updated contract_start_date", contract_type: "some updated contract_type", direct_support: "some updated direct_support", email: "some updated email", expected_contract_end_date: "some updated expected_contract_end_date", federative_unit: "some updated federative_unit", function: "some updated function", graduadion_degree: "some updated graduadion_degree", graduation_course: "some updated graduation_course", institution: "some updated institution", name: "some updated name", phone: "some updated phone", term: "some updated term"}
    @invalid_attrs %{city: nil, contract_start_date: nil, contract_type: nil, direct_support: nil, email: nil, expected_contract_end_date: nil, federative_unit: nil, function: nil, graduadion_degree: nil, graduation_course: nil, institution: nil, name: nil, phone: nil, term: nil}

    def consultant_fixture(attrs \\ %{}) do
      {:ok, consultant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Consultants.create_consultant()

      consultant
    end

    test "list_consultants/0 returns all consultants" do
      consultant = consultant_fixture()
      assert Consultants.list_consultants() == [consultant]
    end

    test "get_consultant!/1 returns the consultant with given id" do
      consultant = consultant_fixture()
      assert Consultants.get_consultant!(consultant.id) == consultant
    end

    test "create_consultant/1 with valid data creates a consultant" do
      assert {:ok, %Consultant{} = consultant} = Consultants.create_consultant(@valid_attrs)
      assert consultant.city == "some city"
      assert consultant.contract_start_date == "some contract_start_date"
      assert consultant.contract_type == "some contract_type"
      assert consultant.direct_support == "some direct_support"
      assert consultant.email == "some email"
      assert consultant.expected_contract_end_date == "some expected_contract_end_date"
      assert consultant.federative_unit == "some federative_unit"
      assert consultant.function == "some function"
      assert consultant.graduadion_degree == "some graduadion_degree"
      assert consultant.graduation_course == "some graduation_course"
      assert consultant.institution == "some institution"
      assert consultant.name == "some name"
      assert consultant.phone == "some phone"
      assert consultant.term == "some term"
    end

    test "create_consultant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Consultants.create_consultant(@invalid_attrs)
    end

    test "update_consultant/2 with valid data updates the consultant" do
      consultant = consultant_fixture()
      assert {:ok, %Consultant{} = consultant} = Consultants.update_consultant(consultant, @update_attrs)
      assert consultant.city == "some updated city"
      assert consultant.contract_start_date == "some updated contract_start_date"
      assert consultant.contract_type == "some updated contract_type"
      assert consultant.direct_support == "some updated direct_support"
      assert consultant.email == "some updated email"
      assert consultant.expected_contract_end_date == "some updated expected_contract_end_date"
      assert consultant.federative_unit == "some updated federative_unit"
      assert consultant.function == "some updated function"
      assert consultant.graduadion_degree == "some updated graduadion_degree"
      assert consultant.graduation_course == "some updated graduation_course"
      assert consultant.institution == "some updated institution"
      assert consultant.name == "some updated name"
      assert consultant.phone == "some updated phone"
      assert consultant.term == "some updated term"
    end

    test "update_consultant/2 with invalid data returns error changeset" do
      consultant = consultant_fixture()
      assert {:error, %Ecto.Changeset{}} = Consultants.update_consultant(consultant, @invalid_attrs)
      assert consultant == Consultants.get_consultant!(consultant.id)
    end

    test "delete_consultant/1 deletes the consultant" do
      consultant = consultant_fixture()
      assert {:ok, %Consultant{}} = Consultants.delete_consultant(consultant)
      assert_raise Ecto.NoResultsError, fn -> Consultants.get_consultant!(consultant.id) end
    end

    test "change_consultant/1 returns a consultant changeset" do
      consultant = consultant_fixture()
      assert %Ecto.Changeset{} = Consultants.change_consultant(consultant)
    end
  end
end
