defmodule PocPubSub.Repo do
  use Ecto.Repo,
    otp_app: :poc_pub_sub,
    adapter: Ecto.Adapters.Postgres
end
