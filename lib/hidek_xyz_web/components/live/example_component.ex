defmodule HidekXyzWeb.Live.ExampleComponent do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, socket |> assign(counter: 0)}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :counter, &(&1 + 1))}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, update(socket, :counter, &(&1 - 1))}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-row flex-wrap items-center gap-3 bg-gray-800 px-3 py-5 rounded justify-center">
      <button
        class="bg-purple-500 rounded-full px-5 py-2 font-semibold"
        phx-click="inc"
        phx-target={@myself}
      >
        +
      </button>
      <h1 class="text-lg font-bold"><%= @content %> <%= @counter %></h1>
      <button
        class="bg-purple-500 rounded-full px-5 py-2 font-semibold"
        phx-click="dec"
        phx-target={@myself}
      >
        -
      </button>
    </div>
    """
  end
end
