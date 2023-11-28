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
      <h1 class="font-bold text-3xl mb-4">Abe Guilherme Hidek</h1>
      <p>
        A generalist working for software development, days off experimenting things with elixir, rust and self-hosting.
      </p>
    </div>
    """
  end
end
