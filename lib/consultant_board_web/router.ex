defmodule ConsultantBoardWeb.Router do
  use ConsultantBoardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ConsultantBoardWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :consultant_board_basic_auth, env: :basic_auth_dashboard_password
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConsultantBoardWeb do
    pipe_through :browser

    get "/", RedirectWithSeeder, to: "/consultant"
    live "/consultant", ConsultantListLive
    live "/consultant/:id", ConsultantShowLive
    live "/federative_unit", FederativeUnitListLive
    live "/travel_tracker", TravelTrackerListLive
    live "/travel_tracker/:id", TravelTrackerShowLive
    live "/consultant_on_the_move", ConsultantOnTheMoveListLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConsultantBoardWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ConsultantBoardWeb.Telemetry
    end
  end

  defp consultant_board_basic_auth(conn, env: env) do
    password = Application.fetch_env!(:consultant_board, env)
    Plug.BasicAuth.basic_auth(conn, username: "admin", password: password)
  end
end
