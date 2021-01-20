defmodule ConsultantBoardWeb.ConsultantShowLive do
  use ConsultantBoardWeb, :live_view

  alias ConsultantBoard.Consultants

  def mount(%{"id" => consultant_id}, _session, socket) do
    IO.puts(consultant_id)
    {:ok, assign(socket, :consultant, Consultants.get_consultant!(consultant_id))}
    # {:ok, socket, temporary_assigns: []}
  end


  def handle_params(params, _url, socket) do

    socket = assign(socket,[])

    {:noreply, socket}
  end
end
