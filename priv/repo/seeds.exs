alias ConsultantBoard.Consultants.Consultant
alias ConsultantBoard.Repo

{:ok, [header | spreadsheet_data]} = ConsultantBoard.DataPuller.GoogleSpreadsheetAPI.extract()

Enum.each(spreadsheet_data,
  fn line ->
    # [name, contract_type, term, direct_support, federative_unit, city, institution, graduation_course, function, graduation_degree, phone, email, contract_start_date, expected_contract_end_date]
    name = Enum.at(line, 0, "")
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
