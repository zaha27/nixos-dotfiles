{ pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./shell.nix
    ./vim.nix
    ./hyprland.nix
    ./alacritty.nix
    ./waybar.nix
    ./wofi.nix
    ./swaync.nix
    ./fastfetch.nix
  ];

  home.username = "zaha";
  home.homeDirectory = "/home/zaha";
  home.stateVersion = "25.11";

  home.pointerCursor = {
    name = "macOS";
    package = pkgs.apple-cursor;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.home-manager.enable = true;
}
