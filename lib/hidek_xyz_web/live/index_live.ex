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
      <div class="mb-4">
        <p class="text-xl indent-2">安部・ギルヘルメ・ヒデK</p>
        <h1 class="font-black text-5xl">Abe Guilherme Hidek</h1>
      </div>
      <div class="text-lg">
        <p>
          A generalist working for software development, days off experimenting things with elixir, rust and self-hosting.
        </p>
      </div>
    </div>
    """
  end
end
