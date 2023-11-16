defmodule HidekXyz.Contents do
  alias HidekXyz.Article

  use NimblePublisher,
    build: Article,
    from: Application.app_dir(:hidek_xyz, "priv/content/**/*.md"),
    as: :articles

  @articles Enum.sort_by(@articles, & &1.publish_date, {:desc, Date})

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  @spec all_articles() :: [%Article{}]
  def all_articles, do: @articles

  def get_article_by_slug!(slug) when is_binary(slug) do
    Enum.find(all_articles(), &(&1.slug == slug)) ||
      raise NotFoundError, "article with slug=#{slug} not found"
  end

  def get_articles_by_tag!(tag) do
    all_articles()
    |> Enum.filter(&(tag in &1.tags))
    |> then(fn
      [] -> raise NotFoundError, "articles with tag=#{tag} not found"
      articles -> articles
    end)
  end
end
