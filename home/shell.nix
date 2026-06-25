{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      fastfetch
    '';
    shellAliases = {
      culcate = "systemctl suspend";
      rebuild = "cd ~/nixos-dotfiles && git add . && sudo nixos-rebuild switch --flake .#nixos";
      update = "cd ~/nixos-dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2 && sudo nix-collect-garbage -d && cd ~/nixos-dotfiles && sudo nixos-rebuild boot --flake .#nixos";
    };
  };
}
