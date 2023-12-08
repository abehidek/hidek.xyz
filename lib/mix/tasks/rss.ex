defmodule Mix.Tasks.Rss do
  use Mix.Task

  alias HidekXyz.Content
  alias HidekXyz.Content.Article

  @destination "priv/static/rss.xml"

  @impl Mix.Task
  def run(_args) do
    items =
      Content.all_articles()
      |> Enum.map(&link_xml/1)
      |> Enum.join()
      |> IO.inspect()

    host = get_host_url()

    document = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <rss version="2.0">
      <channel>
        <title>Guilherme Hidek Abe</title>
        <description>Findings about software engineering, computer science, infra, self-hosting, FOSS and functional programming</description>
        <link>#{host}</link>
        #{items}
      </channel>
    </rss>
    """

    File.write(@destination, document)
  end

  defp get_host_url do
    case System.get_env("PHX_HOST") do
      nil -> "http://localhost:4000"
      host -> "https://#{host}"
    end
  end

  defp link_xml(%Article{} = article) do
    host = get_host_url()

    link = "#{host}/content/#{article.slug}"

    IO.inspect(Map.get(article.frontmatter, :cover))

    maybe_enclosure =
      if nil == Map.get(article.frontmatter, :cover),
        do: "",
        else: """
        <enclosure url="#{host}#{article.frontmatter.cover}" length="1" type="img"/>
        """

    """
    <item>
      <title>#{article.frontmatter.title}</title>
      <description>#{article.frontmatter.description}</description>
      <pubDate>#{Calendar.strftime(article.frontmatter.publish_date, "%a, %d %B %Y 00:00:00 GMT")}</pubDate>
      <link>#{link}</link>
      <guid isPermaLink="true">#{link}</guid>
      #{maybe_enclosure}
    </item>
    """
  end
end
