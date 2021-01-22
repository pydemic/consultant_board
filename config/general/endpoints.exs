import Config

config :consultant_board, ConsultantBoardWeb.Endpoint,
  live_view: [signing_salt: "319+H0R8"],
  pubsub_server: ConsultantBoard.PubSub,
  url: [host: "localhost"],
  render_errors: [view: ConsultantBoardWeb.ErrorView, accepts: ~w(html json), layout: false],
  secret_key_base: "B8VkLcnLfz62bW3VX+izA3W+qC1mmnRYFwoWOSXyzl5HjAO/sVg46fksQR/dWFTy"
