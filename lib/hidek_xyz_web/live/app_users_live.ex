defmodule HidekXyzWeb.AppUsersLive do
  alias Ecto.UUID
  use HidekXyzWeb, :live_view

  alias HidekXyzWeb.{Presence, Endpoint}

  @topic "app_users"

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@topic)
      Presence.track(self(), @topic, UUID.generate(), %{})
    end

    {:ok, socket, layout: false}
  end

  @impl true
  def handle_info(%{event: "presence_diff"}, socket) do
    app_users_count =
      Presence.list(@topic)
      |> Map.keys()
      |> length()

    {:noreply, socket |> assign(app_users_count: app_users_count)}
  end

  @impl true
  def render(%{app_users_count: _} = assigns) do
    ~H"""
    <p>users: <%= @app_users_count %></p>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <p>users: ~</p>
    """
  end
end
