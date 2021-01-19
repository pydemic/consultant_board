defmodule ConsultantBoardWeb.PaginateLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.Consultants

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [consultant: []]}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = 15

    paginate_options = %{page: page, per_page: per_page}
    consultants = Consultants.list_consultants(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        consultants: consultants
      )

    {:noreply, socket}
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to:
          Routes.live_path(
            socket,
            __MODULE__,
            page: socket.assigns.options.page,
            per_page: per_page
          )
      )

    {:noreply, socket}
  end

  defp expires_class(consultant) do
    if Consultants.almost_expired?(consultant), do: "eat-now", else: "fresh"
  end

  defp pagination_link(socket, text, page, per_page, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: per_page
        ),
      class: class
    )
  end
end
