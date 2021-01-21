# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :consultant_board,
  ecto_repos: [ConsultantBoard.Repo]

# Configures the endpoint
config :consultant_board, ConsultantBoardWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "B8VkLcnLfz62bW3VX+izA3W+qC1mmnRYFwoWOSXyzl5HjAO/sVg46fksQR/dWFTy",
  render_errors: [view: ConsultantBoardWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ConsultantBoard.PubSub,
  live_view: [signing_salt: "319+H0R8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :consultant_board,
  google_api_key: System.get_env("CONSULTANT_BOARD_GOOGLE_API_KEY"),
  spreadsheet_id: System.get_env("CONSULTANT_BOARD_SPREADSHEET_ID"),
  spreadsheet_page_consultant: System.get_env("CONSULTANT_BOARD_SPREADSHEET_PAGE_CONSULTANTS"),
  spreadsheet_page_travel_tracker:
    System.get_env("CONSULTANT_BOARD_SPREADSHEET_PAGE_TRAVEL_TRACKER"),
  basic_auth_dashboard_password:
    System.get_env("CONSULTANT_BOARD_BASIC_AUTH_DASHBOARD_PASSWORD", "Pass@123")
