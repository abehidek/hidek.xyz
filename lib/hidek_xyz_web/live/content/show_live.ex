defmodule HidekXyzWeb.Content.ShowLive do
  use HidekXyzWeb, :live_view

  alias HidekXyz.Content

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    article = Content.get_article_by_slug!(slug)

    {:ok, assign(socket, article: article, page_title: "#{slug}/content/hidek.xyz")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <article>
      <div class="mb-5">
        <.link class="font-semibold text-xl" navigate={~p"/content"}>
          Back
        </.link>
      </div>

      <p class="mb-2"><%= @article.frontmatter.publish_date %></p>

      <%= if not is_nil(@article.frontmatter.cover) do %>
        <img
          class="rounded mb-4"
          src={@article.frontmatter.cover}
          alt={"#{@article.frontmatter.title}'s cover image"}
        />
      <% end %>

      <div class="flex gap-2 mb-3">
        <%= for tag <- @article.frontmatter.tags do %>
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

      <%= if not is_nil(@article.frontmatter.series) do %>
        <h2 class="font-semibold text-xl mb-4">
          <%!-- <.link navigate={~p"/content?#{%{series: @article.frontmatter.series.slug}}"}> --%>
          Series: <%= @article.frontmatter.series.title %>, part <%= @article.frontmatter.series.part %>
          <%!-- </.link> --%>
        </h2>
      <% end %>

      <h1 class="font-bold text-5xl mb-4"><%= @article.frontmatter.title %></h1>
      <h3 class="text-xl mb-4"><%= @article.frontmatter.description %></h3>

      <hr />

      <div class="article-body"><%= raw(@article.body) %></div>
    </article>
    """
  end
end
