{ config, pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./shell.nix
    ./vim.nix
  ];

  home.username = "zaha";
  home.homeDirectory = "/home/zaha";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
