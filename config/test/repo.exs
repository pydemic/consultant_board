import Config

config :consultant_board, ConsultantBoard.Repo,
  username: "postgres",
  password: "postgres",
  database: "consultant_board_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
