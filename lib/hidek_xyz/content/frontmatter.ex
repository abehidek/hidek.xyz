defmodule HidekXyz.Content.Frontmatter do
  alias HidekXyz.Markdown
  # alias HidekXyz.Content.Article

  def parse(_path, contents) do
    [_, frontmatter, body] = String.split(contents, ["---", "\n---", "---\n", "\n---\n"])

    # IO.inspect(frontmatter, label: "frontmatter")

    yml = Markdown.parse_yml(frontmatter)

    # IO.inspect(yml, label: "yml")

    {Map.delete(yml, :body), body}

    # [meta, body] = :binary.split(contents, ["\n---\n", "\r\n---\r\n"])
    # IO.inspect(body, label: "Body")
    # IO.inspect(meta, label: "Meta")

    # case Code.eval_string(meta, []) do
    #   {%{} = attrs, _} -> {attrs, body}
    #   _ -> raise "Failed to eval frontmatter"
    # end
  end
end
