defmodule HidekXyz.Content.Frontmatter do
  alias HidekXyz.Content.Parser
  alias HidekXyz.Content.Article.Frontmatter

  def parse(_path, contents) do
    [frontmatter, body] =
      String.split(
        contents,
        [
          "---",
          "\n---",
          "\r\n---",
          "---\n",
          "---\r\n",
          "\n---\n",
          "\r\n---\r\n"
        ],
        trim: true,
        parts: 2
      )

    %Frontmatter{} = yml = frontmatter |> Parser.parse_frontmatter()

    {yml, body}
  end
end
