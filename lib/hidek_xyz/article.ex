defmodule HidekXyz.Article do
  @enforce_keys [:slug, :title, :body, :publish_date, :tags]
  defstruct [:slug, :title, :body, :publish_date, :tags]

  def build(filename, attrs, body) do
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    struct!(__MODULE__,
      slug: slug,
      title: attrs.title,
      body: body,
      publish_date: publish_date,
      tags: attrs.tags
    )
  end
end
