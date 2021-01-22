import Config

config :logger,
  truncate: :infinity

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]
