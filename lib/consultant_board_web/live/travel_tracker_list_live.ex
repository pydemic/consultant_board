defmodule ConsultantBoardWeb.TravelTrackerListLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.TravelTrackers

  def mount(_params, _session, socket) do
    {:ok, socket,
     temporary_assigns: [travel_tracker: [], loading: false, quantity_travel_tracker: 0]}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = 15

    search = params["search"] || ""

    filter = params["filter"] || ""

    sort_by = (params["sort_by"] || "name") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    search_options = %{search: search}
    filter_options = %{filter: filter}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    travel_trackers =
      TravelTrackers.list_travel_trackers(
        paginate: paginate_options,
        search: search_options,
        filter: filter_options,
        sort: sort_options
      )

    quantity_travel_trackers =
      TravelTrackers.get_quantity_travel_trackers(
        search: search_options,
        filter: filter_options
      )

    destination_federatives_units = TravelTrackers.list_of_count_by_destination_federative_unit()

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
        destination_federatives_units,
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
        options:
          paginate_options
          |> Map.merge(search_options)
          |> Map.merge(filter_options)
          |> Map.merge(sort_options),
        travel_trackers: travel_trackers,
        quantity_travel_trackers: quantity_travel_trackers,
        federatives_units_locations: federatives_units_locations
      )

    {:noreply, socket}
  end

  def handle_event("travel-trackers-search", %{"search" => search, "filter" => filter}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(
            socket,
            __MODULE__,
            page: socket.assigns.options.page,
            filter: filter,
            search: search
          )
      )

    {:noreply, socket}
  end

  defp pagination_link(socket, text, page, per_page, search, filter, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: per_page,
          search: search,
          filter: filter
        ),
      class: class
    )
  end

  defp sort_link(socket, text, sort_by, options) do
    text =
      if sort_by == options.sort_by do
        text <> special_char(options.sort_order)
      else
        text
      end

    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          sort_by: sort_by,
          sort_order: toggle_sort_order(options.sort_order),
          page: 1,
          per_page: options.per_page,
          search: options.search,
          filter: options.filter
        )
    )
  end

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp special_char(:asc), do: "⭣"
  defp special_char(:desc), do: "⭡"
end
