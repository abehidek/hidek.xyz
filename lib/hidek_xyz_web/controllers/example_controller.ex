defmodule HidekXyzWeb.ExampleController do
  use HidekXyzWeb, :controller

  alias HidekXyz.Examples

  def index(conn, _params) do
    users = Examples.list_users()
    conn
    |> put_status(:ok)
    |> json(%{
      message: "Hello World",
      users: users
    })
  end

  def create(conn, %{"name" => name, "age" => age}) do
    {:ok, user} = Examples.create_user(%{name: name, age: age})

    conn
    |> put_status(:ok)
    |> json(%{
      message: "User created succesfully",
      user: user
    })
  end
end
