{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
      size = 10;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # GTK4/libadwaita apps read dconf rather than settings.ini, so set both.
  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    font-name = "JetBrainsMono Nerd Font 10";
    document-font-name = "JetBrainsMono Nerd Font 10";
    monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
  };
}
