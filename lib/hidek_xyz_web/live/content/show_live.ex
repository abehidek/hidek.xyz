defmodule HidekXyzWeb.Content.ShowLive do
  use HidekXyzWeb, :live_view

  alias HidekXyz.Contents

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    article = Contents.get_article_by_slug!(slug)

    {:ok, assign(socket, article: article)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <main>
      <div class="mb-5">
        <.link class="font-semibold text-xl" navigate={~p"/content"}>
          Back
        </.link>
      </div>

      <p class="mb-2"><%= @article.publish_date %></p>

      <img class="rounded mb-4" src={@article.cover} alt={"#{@article.title}'s cover image"} />

      <div class="flex gap-2 mb-3">
        <%= for tag <- @article.tags do %>
          <div class="flex ">
            <.link
              class="bg-gray-200 rounded-full px-3 py-1 text-gray-700"
              navigate={~p"/content?#{%{tag: tag}}"}
            >
              <%= tag %>
            </.link>
          </div>
        <% end %>
      </div>

      <h1 class="font-bold text-5xl mb-4"><%= @article.title %></h1>
      <h2 class="text-xl mb-4"><%= @article.description %></h2>

      <hr />

      <div class="mt-12 flex flex-col gap-2 article-body"><%= raw(@article.body) %></div>
    </main>
    """
  end
end
