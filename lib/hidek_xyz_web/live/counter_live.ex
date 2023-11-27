defmodule HidekXyzWeb.CounterLive do
  use HidekXyzWeb, :live_view

  @impl true
  def mount(_params, %{"content" => content}, socket) do
    IO.inspect(socket, label: "[CounterLive mount socket]:")
    {:ok, socket |> assign(counter: 0) |> assign(content: content), layout: false}
  end

  @impl true
  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  @impl true
  def handle_event("dec", _params, socket) do
    {:noreply, update(socket, :counter, &(&1 - 1))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex flex-row flex-wrap items-center gap-3 bg-gray-800 px-3 py-5 rounded justify-center">
      <button class="bg-purple-500 rounded-full px-5 py-2 font-semibold" phx-click="inc">
        +
      </button>
      <h1 class="text-lg font-bold"><%= @content %> <%= @counter %></h1>
      <button class="bg-purple-500 rounded-full px-5 py-2 font-semibold" phx-click="dec">
        -
      </button>
    </div>
    """
  end
end
