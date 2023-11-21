defmodule HidekXyz.Article do
  @enforce_keys [:slug, :title, :description, :body, :publish_date, :tags, :cover, :public]
  defstruct [:slug, :title, :description, :body, :publish_date, :tags, :cover, :public]

  def build(filename, attrs, body) do
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    struct!(__MODULE__,
      slug: slug,
      title: attrs.title,
      description: attrs.description,
      body: body,
      publish_date: publish_date,
      tags: attrs.tags,
      cover: attrs.cover,
      public: attrs.public
    )
  end
end
