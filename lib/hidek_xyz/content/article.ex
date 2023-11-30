defmodule HidekXyz.Content.Article do
  alias HidekXyz.Content.Article.Frontmatter
  @enforce_keys [:slug, :frontmatter, :body]

  defstruct(@enforce_keys)

  defmodule Frontmatter do
    @enforce_keys [:title, :description, :publish_date, :tags, :public]
    @optional_keys [:cover]
    defstruct(@enforce_keys ++ @optional_keys)
  end

  def build(filename, attrs, body) do
    # IO.inspect(attrs, label: "Attrs")
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    maybe_cover = Map.get(attrs, :cover)

    maybe_public = Map.get(attrs, :public)

    struct!(__MODULE__,
      slug: slug,
      body: body,
      frontmatter: %Frontmatter{
        title: attrs.title,
        description: attrs.description,
        publish_date: publish_date,
        tags: attrs.tags,
        cover:
          if(not is_nil(maybe_cover) and maybe_cover |> String.length() > 0,
            do: maybe_cover,
            else: nil
          ),
        public: maybe_public || false
      }
    )
  end
end
