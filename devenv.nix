{ pkgs, ... }:

{
  packages = with pkgs; [
    inotify-tools
  ];

  languages = {
    elixir = {
      enable = true;
    };
    javascript = {
      enable = true;
      package = pkgs.nodejs_20;
    };
  };
}
