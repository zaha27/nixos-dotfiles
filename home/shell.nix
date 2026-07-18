{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      fastfetch

      anim() {
        case "$1" in
          on)     hyprctl keyword animations:enabled 1 >/dev/null && echo "animations on" ;;
          off)    hyprctl keyword animations:enabled 0 >/dev/null && echo "animations off" ;;
          toggle|"")
            state=$(hyprctl getoption animations:enabled -j | ${pkgs.jq}/bin/jq -r .int)
            if [ "$state" = "1" ]; then
              hyprctl keyword animations:enabled 0 >/dev/null && echo "animations off"
            else
              hyprctl keyword animations:enabled 1 >/dev/null && echo "animations on"
            fi
            ;;
          *) echo "usage: anim [on|off|toggle]" >&2; return 1 ;;
        esac
      }
    '';
    shellAliases = {
      culcate = "systemctl suspend";
      rebuild = "cd ~/nixos-dotfiles && git add . && sudo nixos-rebuild switch --flake .#nixos";
      update = "cd ~/nixos-dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#nixos";
      clean = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations +2 && sudo nix-collect-garbage -d && cd ~/nixos-dotfiles && sudo nixos-rebuild boot --flake .#nixos";
      rm-gtk = "rm -f ~/.gtkrc-2.0 ~/.gtkrc-2.0.hm-bak";
    };
  };
}
