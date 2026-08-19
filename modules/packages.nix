{ pkgs, pkgs-unstable, ... }:

{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget curl killall efibootmgr git
    vscode
    discord google-chrome
    unzip zip p7zip unrar
    wl-clipboard
    grim slurp
    playerctl brightnessctl
    pavucontrol
    btop
    blueman
    swaynotificationcenter
    kdePackages.kcalc
    kdePackages.partitionmanager
    kdePackages.sddm-kcm
    nerd-fonts.jetbrains-mono
    inter
    mangohud
    protonup-qt
    jetbrains-toolbox
    nodejs_22
    pkgs-unstable.claude-code
    python3
    uv
  ];

  fonts = {
    packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-color-emoji
    ];

    # Without these, fontconfig picked Noto Sans for UI and Hack for monospace.
    # Noto stays last as the fallback for scripts JetBrains Mono lacks (CJK,
    # Cyrillic beyond Latin-1, etc.) — JBM only covers Latin/Greek/Cyrillic.
    fontconfig.defaultFonts = {
      sansSerif = [ "JetBrainsMono Nerd Font" "Noto Sans" ];
      serif = [ "JetBrainsMono Nerd Font" "Noto Serif" ];
      monospace = [ "JetBrainsMono Nerd Font Mono" "Noto Sans Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
