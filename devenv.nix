{ pkgs, ... }:

{
  packages = with pkgs; [
    inotify-tools
    flyctl
  ];

  languages = {
    c.enable = true;
    rust = {
      enable = true;
      channel = "stable";
    };
    elixir = {
      enable = true;
    };
    javascript = {
      enable = true;
      package = pkgs.nodejs_20;
    };
  };
}
