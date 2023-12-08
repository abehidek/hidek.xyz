defmodule HidekXyzWeb.ContentUsersLive do
  alias Ecto.UUID
  use HidekXyzWeb, :live_view

  alias HidekXyzWeb.{Presence, Endpoint}

  @impl true
  def mount(_params, %{"id" => id} = _session, socket) do
    topic = "content_users_" <> id

    if connected?(socket) do
      Endpoint.subscribe(topic)
      Presence.track(self(), topic, UUID.generate(), %{})
    end

    {:ok, socket |> assign(topic: topic), layout: false}
  end

  @impl true
  def handle_info(%{event: "presence_diff"}, socket) do
    content_users_count =
      Presence.list(socket.assigns.topic)
      |> Map.keys()
      |> length()

    {:noreply, socket |> assign(content_users_count: content_users_count)}
  end

  @impl true
  def render(%{content_users_count: _} = assigns) do
    ~H"""
    <p>on this page: <%= @content_users_count %></p>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <p>on this page: ~</p>
    """
  end
end
