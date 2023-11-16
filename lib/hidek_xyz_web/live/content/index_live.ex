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
end
