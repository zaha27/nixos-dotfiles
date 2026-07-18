{ pkgs, ... }:

let
  sddmMonitorSetup = pkgs.writeShellScript "sddm-monitor-setup" ''
    ${pkgs.xorg.xrandr}/bin/xrandr | ${pkgs.gawk}/bin/awk '
      /^[^ ].* connected/ { out=$1; next }
      /^ +[0-9]+x[0-9]+/ && out { print out, $1; out="" }
    ' | while read -r out mode; do
      if [ "$mode" != "3840x2160" ]; then
        ${pkgs.xorg.xrandr}/bin/xrandr --output "$out" --off || true
      fi
    done
  '';
in
{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
    theme = "catppuccin-sddm-corners";
    settings.General.InputMethod = "";
  };
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = true;

  services.xserver.displayManager.setupCommands = ''
    ${sddmMonitorSetup}
  '';

  environment.systemPackages = [ pkgs.catppuccin-sddm-corners ];

  services.printing.enable = true;
}
