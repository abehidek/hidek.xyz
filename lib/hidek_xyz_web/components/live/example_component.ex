defmodule HidekXyzWeb.Live.ExampleComponent do
  use Phoenix.LiveComponent

  def mount(socket) do
    {:ok, socket |> assign(counter: 0)}
  end

  def handle_event("inc", _params, socket) do
    {:noreply, update(socket, :counter, & &1 + 1)}
  end

  def handle_event("dec", _params, socket) do
    {:noreply, update(socket, :counter, & &1 - 1)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-start gap-3 bg-blue-500">
      <p>Example live component</p>
      <div>
        <div><%= @counter %></div>
        <button phx-click="inc" phx-target={@myself}>+</button>
        <button phx-click="dec" phx-target={@myself}>-</button>
      </div>
      <div><%= @content %></div>
    </div>
    """
  end
end
