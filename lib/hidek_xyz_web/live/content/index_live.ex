defmodule HidekXyzWeb.Content.IndexLive do
  use HidekXyzWeb, :live_view

  alias HidekXyz.Content

  @page_title "Content - hidek.xyz"

  @impl true
  def mount(%{"tag" => tag}, _session, socket) do
    articles = Content.get_articles_by_tag!(tag)

    {:ok, assign(socket, articles: articles, tag: tag, page_title: @page_title)}
  end

  @impl true
  def mount(_params, _session, socket) do
    articles = Content.all_articles()

    {:ok, assign(socket, articles: articles, tag: nil, page_title: @page_title)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <content class="container mx-auto py-8">
      <%= if is_nil(@tag) do %>
        <div>
          <h1 class="font-bold text-4xl mb-4">Latest articles</h1>
        </div>
      <% else %>
        <div class="flex justify-between items-center mb-4">
          <h1 class="font-bold text-3xl">Articles tagged with "<%= @tag %>"</h1>
          <.link
            class="bg-blue-500 px-2 py-1 rounded text-white text-sm font-semibold"
            navigate={~p"/content"}
          >
            clear filter
          </.link>
        </div>
      <% end %>

      <ul class="mt-12">
        <%= if length(@articles) < 1 do %>
          <h2 class="text-2xl">Oops, no articles found ¯\_(ツ)_/¯</h2>
        <% else %>
          <%= for article <- @articles do %>
            <li class="mb-4 relative">
              <.link class="block" navigate={~p"/content/" <> article.slug}>
                <h2 class="text-3xl font-bold mb-2"><%= article.frontmatter.title %></h2>
                <h3 class="text-xl mb-1"><%= article.frontmatter.description %></h3>
                <p class="text-lg"><%= article.frontmatter.publish_date %></p>
              </.link>
              <%!-- <div class="absolute w-full top-0 flex flex-wrap gap-2 p-1">
                <div class="flex flex-wrap bg-black bg-opacity-10 rounded-xl p-3 gap-3">
                  <%= for tag <- article.tags do %>
                    <div class="flex flex-wrap">
                      <.link
                        class="bg-gray-200 rounded-xl px-3 py-1 text-sm text-gray-700"
                        navigate={~p"/content?#{%{tag: tag}}"}
                      >
                        <%= tag %>
                      </.link>
                    </div>
                  <% end %>
                </div>
              </div> --%>
            </li>
          <% end %>
        <% end %>
      </ul>
    </content>
    """
  end
end
