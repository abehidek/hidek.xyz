defmodule HidekXyzWeb.Content.IndexLive do
  use HidekXyzWeb, :live_view

  alias HidekXyz.Contents

  @impl true
  def mount(_params, _session, socket) do
    articles = Contents.all_posts()

    {:ok, assign(socket, articles: articles)}
  end
end
