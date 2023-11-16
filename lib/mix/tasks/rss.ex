defmodule Mix.Tasks.Rss do
  use Mix.Task

  @destination "priv/static/rss.xml"

  @impl Mix.Task
  def run(_args) do
    items = HidekXyz.Contents.all_articles()
    |> Enum.map(&link_xml/1)
    |> Enum.join()
    |> IO.inspect()

    document = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
      <channel>
        #{items}
      </channel>
    </rss>
    """

    File.write(@destination, document)
  end

  defp link_xml(%HidekXyz.Article{} = article) do
    host = case System.get_env("PHX_HOST") do
      nil -> "http://localhost:4000"
      host -> "https://#{host}"
    end

    link = "#{host}/content/#{article.slug}"

    """
    <item>
      <title>#{article.title}</title>
      <description>#{article.title}</description>
      <pubDate>#{Calendar.strftime(article.publish_date, "%a, %d %B %Y 00:00:00 +0000")}</pubDate>
      <link>#{link}</link>
      <guid isPermaLink="true">#{link}</guid>
    </item>
    """
  end
end
