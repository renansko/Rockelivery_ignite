defmodule RockeliveryWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :rockelivery

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.LoadResource
  plug Guardian.Plug.EnsureAuthenticated
end
