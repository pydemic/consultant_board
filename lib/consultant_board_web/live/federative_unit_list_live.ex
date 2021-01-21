defmodule ConsultantBoardWeb.FederativeUnitListLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.Consultants

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [consultants: [], loading: false]}
  end

  def handle_params(_params, _url, socket) do
    federatives_units = Consultants.list_of_count_by_federative_unit()

    fu_locations = %{
      "Acre" => %{latitude: -8.77, longitude: -70.55},
      "Alagoas" => %{latitude: -9.71, longitude: -35.73},
      "Amazonas" => %{latitude: -3.07, longitude: -61.66},
      "Amapá" => %{latitude: 1.41, longitude: -51.77},
      "Bahia" => %{latitude: -12.96, longitude: -38.51},
      "Ceará" => %{latitude: -3.71, longitude: -38.54},
      "Distrito Federal" => %{latitude: -15.83, longitude: -47.86},
      "Espírito Santo" => %{latitude: -19.19, longitude: -40.34},
      "Goiás" => %{latitude: -16.64, longitude: -49.31},
      "Maranhão" => %{latitude: -2.55, longitude: -44.30},
      "Mato Grosso" => %{latitude: -12.64, longitude: -55.42},
      "Mato Grosso do Sul" => %{latitude: -20.51, longitude: -54.54},
      "Minas Gerais" => %{latitude: -18.10, longitude: -44.38},
      "Pará" => %{latitude: -5.53, longitude: -52.29},
      "Paraíba" => %{latitude: -7.06, longitude: -35.55},
      "Paraná" => %{latitude: -24.89, longitude: -51.55},
      "Pernambuco" => %{latitude: -8.28, longitude: -35.07},
      "Piauí" => %{latitude: -8.28, longitude: -43.68},
      "Rio de Janeiro" => %{latitude: -22.84, longitude: -43.15},
      "Rio Grande do Norte" => %{latitude: -5.22, longitude: -36.52},
      "Rondônia" => %{latitude: -11.22, longitude: -62.80},
      "Rio Grande do Sul" => %{latitude: -30.01, longitude: -51.22},
      "Roraima" => %{latitude: 1.89, longitude: -61.22},
      "Santa Catarina" => %{latitude: -27.33, longitude: -49.44},
      "Sergipe" => %{latitude: -10.90, longitude: -37.07},
      "São Paulo" => %{latitude: -23.55, longitude: -46.64},
      "Tocantins" => %{latitude: -10.25, longitude: -48.25}
    }

    federatives_units_locations =
      Enum.map(
        federatives_units,
        fn fu ->
          %{
            name: fu.name,
            latitude: Map.get(Map.get(fu_locations, fu.name, %{}), :latitude, ""),
            longitude: Map.get(Map.get(fu_locations, fu.name, %{}), :longitude, ""),
            quantity: fu.quantity
          }
        end
      )

    socket =
      assign(socket,
        federatives_units: federatives_units,
        federatives_units_locations: federatives_units_locations
      )

    {:noreply, socket}
  end
end
