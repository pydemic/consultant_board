defmodule ConsultantBoardWeb.FederativeUnitListLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.Consultants

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [consultants: [], loading: false]}
  end

  def handle_params(_params, _url, socket) do
    federatives_units = Consultants.list_of_count_by_federative_unit()

    socket = assign(socket, federatives_units: federatives_units)

    {:noreply, socket}
  end
end
