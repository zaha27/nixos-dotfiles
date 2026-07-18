{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/boot.nix
    ../modules/nix-settings.nix
    ../modules/network.nix
    ../modules/locale.nix
    ../modules/desktop.nix
    ../modules/audio.nix
    ../modules/users.nix
    ../modules/packages.nix
    ../modules/nvidia.nix
    ../modules/bluetooth.nix
    ../modules/gaming.nix
  ];

  networking.hostName = "nixos";

  system.stateVersion = "25.11";
}
