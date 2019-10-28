# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
# config app_name, name_space(这个时可选的参数)，kvs
'''
Application.get_all_env(:study)
[
  {StudyWeb.Endpoint,
   [
     url: [host: "localhost"],
     secret_key_base: "1KF+FzqICM+avHpZSZbCGvAtAOEnvDbh99+M6hg+cd/Pt4tIhY4qVEyUq2/g0gvL",
     render_errors: [view: StudyWeb.ErrorView, accepts: ["html", "json"]],
     pubsub: [name: Study.PubSub, adapter: Phoenix.PubSub.PG2],
     http: [port: 4000],
     debug_errors: true,
     code_reloader: true,
     check_origin: false,
     watchers: [
       node: [
         "node_modules/webpack/bin/webpack.js",
         "--mode",
         "development",
         "--watch-stdin",
         {:cd, "/Users/leiding/workdir/elixir/webtest/study/assets"}
       ]
     ],
     live_reload: [
       patterns: [~r/priv\/static\/.*(js|css|png|jpeg|jpg|gif|svg)$/,
        ~r/priv\/gettext\/.*(po)$/, ~r/lib\/study_web\/views\/.*(ex)$/,
        ~r/lib\/study_web\/templates\/.*(eex)$/]
     ]
   ]},
  {:port, 5000}
]
'''

config :study, StudyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1KF+FzqICM+avHpZSZbCGvAtAOEnvDbh99+M6hg+cd/Pt4tIhY4qVEyUq2/g0gvL",
  render_errors: [view: StudyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Study.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  level: :info,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures for the data receiver
# config application，kvs
config :study,
  port: 5000,
  # This is for HL7 client message sending interval
  interval: 1000

config :elixir_mllp, dispatcher_module: HL7MessageBox

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
