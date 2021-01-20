defmodule ConsultantBoardWeb.ConsultantShowLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.Consultants

  def mount(%{"id" => consultant_id}, _session, socket) do
    {:ok, assign(socket, :consultant, Consultants.get_consultant!(consultant_id))}
  end

  def handle_params(_params, _url, socket) do
    socket = assign(socket, [])

    {:noreply, socket}
  end
end
