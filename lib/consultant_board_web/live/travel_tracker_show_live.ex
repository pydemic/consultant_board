defmodule ConsultantBoardWeb.TravelTrackerShowLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.TravelTrackers

  def mount(%{"id" => travel_tracker_id}, _session, socket) do
    {:ok, assign(socket, :travel_tracker, TravelTrackers.get_travel_tracker!(travel_tracker_id))}
  end

  def handle_params(_params, _url, socket) do
    socket = assign(socket, [])

    {:noreply, socket}
  end
end
