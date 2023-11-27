defmodule HidekXyzWeb.IndexLive do
  use HidekXyzWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h1>Welcome to new.hidek.xyz</h1>
    </div>
    """
  end
end
