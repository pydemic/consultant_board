import Config

config :consultant_board,
  spreadsheet_id: System.get_env("CONSULTANT_BOARD__SPREADSHEET_ID"),
  spreadsheet_page_consultant: System.get_env("CONSULTANT_BOARD__SPREADSHEET_PAGE_CONSULTANT"),
  spreadsheet_page_travel_tracker:
    System.get_env("CONSULTANT_BOARD__SPREADSHEET_PAGE_TRAVEL_TRACKER"),
  basic_auth_dashboard_password:
    System.get_env("CONSULTANT_BOARD__BASIC_AUTH_DASHBOARD_PASSWORD", "Pass@123")
