defmodule ConsultantBoard.Repo do
  use Ecto.Repo,
    otp_app: :consultant_board,
    adapter: Ecto.Adapters.Postgres
end
