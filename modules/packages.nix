{ pkgs, ... }:

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
    claude-code
    python3
    uv
  ];

  fonts.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
  ];
}
