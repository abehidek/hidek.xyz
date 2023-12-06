defmodule HidekXyz.Content.Article do
  alias HidekXyz.Content.Article.Frontmatter
  @enforce_keys [:slug, :frontmatter, :body]

  defstruct(@enforce_keys)

  defmodule Frontmatter do
    @enforce_keys [:title, :description, :publish_date, :tags, :public]
    @optional_keys [:cover, :series]
    defstruct(@enforce_keys ++ @optional_keys)
  end

  def build(filename, attrs, body) do
    # IO.inspect(attrs, label: "Attrs")
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    maybe_cover = Map.get(attrs, :cover)

    maybe_public = Map.get(attrs, :public)

    maybe_series = Map.get(attrs, :series)

    struct!(__MODULE__,
      slug: slug,
      body: body,
      frontmatter: %Frontmatter{
        title: attrs.title,
        description: attrs.description,
        publish_date: publish_date,
        tags: attrs.tags,
        series:
          if(not is_nil(maybe_series) and maybe_series |> String.length() > 0,
            do: maybe_series,
            else: nil
          ),
        cover:
          if(not is_nil(maybe_cover) and maybe_cover |> String.length() > 0,
            do: maybe_cover,
            else: nil
          ),
        # defaults to false
        public: maybe_public || false
      }
    )
  end
end
