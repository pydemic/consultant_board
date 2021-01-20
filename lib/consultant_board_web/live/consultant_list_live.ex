defmodule ConsultantBoardWeb.ConsultantListLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.Consultants

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [consultants: [], loading: false]}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = 15

    search = params["search"] || ""

    sort_by = (params["sort_by"] || "name") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    search_options = %{search: search}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    consultants = Consultants.list_consultants(
      paginate: paginate_options,
      search: search_options,
      sort: sort_options
    )

    socket =
      assign(socket,
        options: paginate_options |> Map.merge(search_options) |> Map.merge(sort_options),
        consultants: consultants
      )

    {:noreply, socket}
  end

  defp pagination_link(socket, text, page, per_page, search, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: per_page,
          search: search
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
          page: options.page,
          per_page: options.per_page,
          search: options.search
        )
    )
  end

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp special_char(:asc), do: "⭣"
  defp special_char(:desc), do: "⭡"
end
