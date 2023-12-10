defmodule HidekXyzWeb.ContentViewsLive do
  use HidekXyzWeb, :live_view

  alias HidekXyzWeb.{Endpoint}

  @impl true
  def mount(_params, %{"id" => id} = _session, socket) do
    topic = "content_views_" <> id

    socket =
      if connected?(socket) do
        {:ok, %HidekXyz.Content.LiveViews.ContentViews{} = content_views} =
          HidekXyz.Content.LiveViews.get(id)

        Endpoint.subscribe(topic)

        socket |> assign(content_views_count: content_views.count)
      else
        socket
      end

    {:ok, socket, layout: false}
  end

  @impl true
  def handle_info(%{event: "inc"}, socket) do
    {:noreply, socket |> assign(content_views_count: socket.assigns.content_views_count + 1)}
  end

  @impl true
  def render(%{content_views_count: _} = assigns) do
    ~H"""
    <p>views: <%= @content_views_count %></p>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <p>views: ~</p>
    """
  end
end
