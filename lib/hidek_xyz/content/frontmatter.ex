defmodule HidekXyz.Content.Frontmatter do
  alias HidekXyz.Content.Parser
  alias HidekXyz.Content.Article.Frontmatter

  def parse(_path, contents) do
    [_, frontmatter, body] =
      String.split(contents, [
        "---",
        "\n---",
        "\r\n---",
        "---\n",
        "---\r\n",
        "\n---\n",
        "\r\n---\r\n"
      ])

    %Frontmatter{} = yml = Parser.parse_frontmatter(frontmatter)

    {yml, body}
  end
end
