defmodule HidekXyz.Article do
  @enforce_keys [:slug, :title, :body, :publish_date]
  defstruct [:slug, :title, :body, :publish_date]

  def build(filename, attrs, body) do
    slug = Path.basename(filename, ".md")

    publish_date = Date.from_iso8601!(attrs.publish_date)

    struct!(__MODULE__, [slug: slug, title: attrs.title, body: body, publish_date: publish_date])
  end
end
