alias ConsultantBoard.DataPuller.Seeder

defmodule ConsultantBoardWeb.Redirect do
  def init(opts), do: opts

  def call(conn, opts) do
    Seeder.seeder()

    conn
    |> Phoenix.Controller.redirect(opts)
    |> Plug.Conn.halt()
  end
end
