defmodule HidekXyz.Contents do
  alias HidekXyz.Article

  use NimblePublisher,
    build: Article,
    from: "content/**/*.md",
    as: :articles,
    highlighters: [:markup_elixir, :markup_erlang]

  @articles Enum.sort_by(@articles, &(&1.publish_date), {:desc, Date})

  defmodule NotFoundError do
    defexception [:message, plug_status: 404]
  end

  def all_posts, do: @articles

  def get_post_by_slug!(slug) when is_binary(slug) do
    Enum.find(all_posts(), &(&1.slug == slug)) || raise NotFoundError, "post with slug=#{slug} not found"
  end
end
