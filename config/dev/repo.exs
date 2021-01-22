import Config

config :consultant_board, ConsultantBoard.Repo,
  username: "consultant_board_live",
  password: "consultant_board_live",
  database: "consultant_board_live_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  log: false
