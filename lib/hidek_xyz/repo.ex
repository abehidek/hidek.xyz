defmodule HidekXyz.Repo do
  use Ecto.Repo,
    otp_app: :hidek_xyz,
    adapter: Ecto.Adapters.SQLite3
end
