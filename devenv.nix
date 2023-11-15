{ pkgs, ... }:

{
  packages = with pkgs; [
    inotify-tools
    flyctl
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
