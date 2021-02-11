import Config

defmodule ConsultantBoard.Releases.Helper do
  def endpoint_settings do
    port = get_env("PORT", :integer, 80)

    settings = [
      check_origin: get_env("ORIGIN_HOSTNAMES", :list, []),
      http: [
        port: port,
        transport_options: [socket_opts: [:inet6]]
      ],
      secret_key_base: get_env!("SECRET_KEY_BASE"),
      url: [
        host: get_env!("HOSTNAME"),
        port: port
      ]
    ]

    if get_env("HTTPS", :boolean, true) do
      https_settings =
        case get_env("CACERTFILE_PATH", nil) do
          nil -> []
          cacertfile -> [cacertfile: cacertfile]
        end

      Keyword.merge(settings,
        https:
          Keyword.merge(https_settings,
            cipher_suite: :strong,
            certfile: get_env!("CERTFILE_PATH"),
            keyfile: get_env!("KEYFILE_PATH"),
            otp_app: :consultant_board,
            port: 443
          )
      )
    else
      settings
    end
  end

  def consultant_board_settings do
    [
      basic_auth_dashboard_password: get_env!("BASIC_AUTH_DASHBOARD_PASSWORD"),
      spreadsheet_id: get_env!("SPREADSHEET_ID"),
      spreadsheet_page_consultant: get_env!("SPREADSHEET_PAGE_CONSULTANT"),
      spreadsheet_page_travel_tracker: get_env!("SPREADSHEET_PAGE_TRAVEL_TRACKER")
    ]
  end

  def goth_setting do
    get_env!("SERVICE_ACCOUNT")
  end

  def repo_settings do
    settings = [
      pool_size: get_env("DATABASE_POOL_SIZE", :integer, 16),
      ssl: get_env("DATABASE_SSL", :boolean, false),
      timeout: 600_000,
      queue_target: 10_000,
      queue_interval: 100_000
    ]

    case get_env("DATABASE_URL", nil) do
      nil ->
        Keyword.merge(settings,
          database: get_env("DATABASE_NAME", "consultant_board"),
          hostname: get_env("DATABASE_HOSTNAME", "postgres"),
          password: get_env("DATABASE_PASSWORD", "consultant_board"),
          username: get_env("DATABASE_USERNAME", "consultant_board")
        )

      url ->
        Keyword.merge(settings, url: url)
    end
  end

  defp get_env(name, type \\ :string, default) do
    env_name = "CONSULTANT_BOARD__#{name}"

    case {System.get_env(env_name), type} do
      {nil, _type} -> default
      {value, :atom} -> String.to_atom(value)
      {value, :boolean} -> String.to_existing_atom(value)
      {value, :integer} -> String.to_integer(value)
      {value, :list} -> String.split(value, ",")
      {value, :string} -> value
    end
  end

  defp get_env!(env_name, type \\ :string) do
    case get_env(env_name, type, nil) do
      nil -> raise "environment variable #{env_name} is missing"
      value -> value
    end
  end
end

alias ConsultantBoard.Releases.Helper

config :consultant_board, ConsultantBoardWeb.Endpoint, Helper.endpoint_settings()
config :consultant_board, ConsultantBoard.Repo, Helper.repo_settings()
config :consultant_board, Helper.consultant_board_settings()
config :goth, json: Helper.goth_setting()
