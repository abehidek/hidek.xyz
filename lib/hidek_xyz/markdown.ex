defmodule HidekXyz.Markdown do
  use Rustler, otp_app: :hidek_xyz, crate: "hidekxyz_markdown"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
  def test(_a, _b), do: :erlang.nif_error(:nif_not_loaded)

  # frontmatter(erlang string/binary) -> yml
  def parse_yml(_frontmatter), do: :erlang.nif_error(:nif_not_loaded)
end
