alias ConsultantBoard.DataPuller.Seeder

require Logger

defmodule ConsultantBoardWeb.RedirectWithSeeder do
  def init(opts), do: opts

  def call(conn, opts) do
    case Seeder.seeder() do
      :error ->
        error = "Não foi possível atualizar os registros"
        opts = [to: Keyword.get(opts, :to) <> "?error=" <> error]

        redirect(conn, opts)

      _ ->
        Logger.info("Seeder finished the job")
        redirect(conn, opts)
    end
  end

  defp redirect(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)
    |> Plug.Conn.halt()
  end
end
