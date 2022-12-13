defmodule CarList.Repo do
  use Ecto.Repo,
    otp_app: :car_list,
    adapter: Ecto.Adapters.Postgres
end
