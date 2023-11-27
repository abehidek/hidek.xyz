defmodule HidekXyzWeb.Content.IndexLive do
  use HidekXyzWeb, :live_view

  alias HidekXyz.Contents

  @impl true
  def mount(%{"tag" => tag}, _session, socket) do
    articles = Contents.get_articles_by_tag!(tag)

    {:ok, assign(socket, articles: articles, tag: tag)}
  end

  @impl true
  def mount(_params, _session, socket) do
    articles = Contents.all_articles()

    {:ok, assign(socket, articles: articles, tag: nil)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <content class="container mx-auto py-8">
      <%= if is_nil(@tag) do %>
        <div>
          <h1 class="font-bold text-3xl mb-4">Latest posts</h1>
        </div>
      <% else %>
        <div class="flex justify-between items-center mb-4">
          <h1 class="font-bold text-3xl">Posts tagged with "<%= @tag %>"</h1>
          <.link
            class="bg-blue-500 px-2 py-1 rounded text-white text-sm font-semibold"
            navigate={~p"/content"}
          >
            clear filter
          </.link>
        </div>
      <% end %>
      <ul>
        <%= for article <- @articles do %>
          <li class="mb-4">
            <.link class="block mb-2" navigate={~p"/content/#{article.slug}"}>
              <img class="rounded" src={article.cover} alt={"#{article.title}'s cover image"} />
              <p class="text-xl font-bold"><%= article.title %></p>
              <h3><%= article.title %></h3>
              <p><%= article.publish_date %></p>
            </.link>
            <div class="flex gap-2">
              <%= for tag <- article.tags do %>
                <div class="flex ">
                  <.link
                    class="bg-gray-200 rounded-full px-3 py-1 text-sm text-gray-700"
                    navigate={~p"/content?#{%{tag: tag}}"}
                  >
                    <%= tag %>
                  </.link>
                </div>
              <% end %>
            </div>
          </li>
        <% end %>
      </ul>
    </content>
    """
  end
end
