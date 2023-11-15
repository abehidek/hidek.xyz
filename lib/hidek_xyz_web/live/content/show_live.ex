defmodule HidekXyzWeb.Content.ShowLive do
  use HidekXyzWeb, :live_view

  alias HidekXyz.Contents

  @impl true
  def mount(%{"slug" => slug}, _session, socket) do
    article = Contents.get_post_by_slug!(slug)

    {:ok, assign(socket, article: article)}
  end
end
