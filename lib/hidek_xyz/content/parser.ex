defmodule HidekXyz.Content.Parser do
  use Rustler, otp_app: :hidek_xyz, crate: "hidekxyz_parser"

  # When your NIF is loaded, it will override this function.
  # frontmatter(erlang string/binary) -> yml
  def parse_frontmatter(_frontmatter), do: :erlang.nif_error(:nif_not_loaded)
end
