defmodule HidekXyz.Content.Article do
  @enforce_keys [:slug, :title, :description, :body, :publish_date, :tags, :public]
  @optional_keys [:cover]

  defstruct(@enforce_keys ++ @optional_keys)

  def build(filename, attrs, body) do
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    maybe_cover = Map.get(attrs, :cover)

    maybe_public = Map.get(attrs, :public)

    struct!(__MODULE__,
      slug: slug,
      title: attrs.title,
      description: attrs.description,
      body: body,
      publish_date: publish_date,
      tags: attrs.tags,
      cover:
        if(not is_nil(maybe_cover) and maybe_cover |> String.length() > 0,
          do: maybe_cover,
          else: nil
        ),
      public: maybe_public || false
    )
  end
end
