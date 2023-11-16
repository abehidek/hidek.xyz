defmodule HidekXyz.Contents do
  alias HidekXyz.Article

  use NimblePublisher,
    build: Article,
    from: "content/**/*.md",
    as: :articles,
    highlighters: [:makeup_elixir, :makeup_erlang]

  @articles Enum.sort_by(@articles, &(&1.publish_date), {:desc, Date})

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  def all_articles, do: @articles

  def get_article_by_slug!(slug) when is_binary(slug) do
    Enum.find(all_articles(), &(&1.slug == slug)) || raise NotFoundError, "article with slug=#{slug} not found"
  end
end
