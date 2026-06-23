# Configurație de sistem — zaha (NixOS 25.11, KDE Plasma 6)
# Portată din vechea config GNOME/Hyprland. hardware-configuration.nix
# rămâne cel generat proaspăt de noua instalare — NU îl înlocui.

{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
    ];

  # ─────────────────────────────────────
  # BOOTLOADER (Limine) — dual boot Windows pe alt SSD
  # ─────────────────────────────────────
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.limine = {
    enable = true;
    style = {
      wallpapers = [ ./images/wallpaper-limine-blur.jpg ];
      wallpaperStyle = "stretched";
      backdrop = "000000";
    };
    # GUID-ul + bootmgfw sunt pe ESP-ul Windows (alt SSD, neatins) → rămân la fel
    extraEntries = ''
      /Windows 11
        protocol: efi_chainload
        image_path: guid(5186fbe0-eea6-47f3-b926-6f1ba8557b49):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  # ESP-ul Windows montat read-only (opțional, util pt. inspecție din Linux).
  # nofail = nu blochează boot-ul dacă lipsește. Verifică UUID-ul cu `blkid`.
  fileSystems."/boot/efi-windows" = {
    device = "/dev/disk/by-uuid/000A-90C6";
    fsType = "vfat";
    options = [ "ro" "nofail" "umask=0077" ];
  };

  # NOTĂ: NU redeclara fileSystems."/boot" aici — vine din hardware-configuration.nix
  # cu UUID-ul nou, corect.

  # ─────────────────────────────────────
  # NIX SETTINGS
  # ─────────────────────────────────────
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # ─────────────────────────────────────
  # NETWORKING
  # ─────────────────────────────────────
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # ─────────────────────────────────────
  # LOCALIZATION
  # ─────────────────────────────────────
  time.timeZone = "Europe/Bucharest";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ro_RO.UTF-8";
    LC_IDENTIFICATION = "ro_RO.UTF-8";
    LC_MEASUREMENT = "ro_RO.UTF-8";
    LC_MONETARY = "ro_RO.UTF-8";
    LC_NAME = "ro_RO.UTF-8";
    LC_NUMERIC = "ro_RO.UTF-8";
    LC_PAPER = "ro_RO.UTF-8";
    LC_TELEPHONE = "ro_RO.UTF-8";
    LC_TIME = "ro_RO.UTF-8";
  };

  # ─────────────────────────────────────
  # DESKTOP — KDE Plasma 6 + SDDM (Wayland)
  # ─────────────────────────────────────
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  # teme coerente și pentru aplicațiile Qt5 sub Plasma 6
  services.desktopManager.plasma6.enableQt5Integration = true;

  # layout tastatură (funcționează și fără X)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ─────────────────────────────────────
  # AUDIO (Pipewire)
  # plasma6 activează deja pipewire, dar îl ținem explicit
  # ─────────────────────────────────────
  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ─────────────────────────────────────
  # USERS
  # ─────────────────────────────────────
  users.users.zaha = {
    isNormalUser = true;
    description = "Andrei";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # ─────────────────────────────────────
  # PROGRAMS & PACKAGES
  # ─────────────────────────────────────
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # base CLI
    wget
    curl
    vim
    killall
    efibootmgr
    git

    # editor
    vscode

    # terminal preferat
    alacritty

    # apps
    discord
    google-chrome

    # arhive
    unzip
    zip
    p7zip
    unrar

    # KDE utils (alege ce vrei, sunt opționale)
    kdePackages.kcalc            # calculator
    kdePackages.partitionmanager # gestionare partiții
    kdePackages.sddm-kcm         # modul SDDM în System Settings
    kdePackages.kcolorpicker     # color picker
    wl-clipboard

    # rețea (KDE are deja applet, dar îl lăsăm pt. tray clasic dacă vrei)
    networkmanagerapplet

    # fonts (și în fonts.packages)
    nerd-fonts.jetbrains-mono
    inter
  ];

  # Scoate aplicații Plasma pe care nu le vrei (decomentează ce nu folosești)
  # environment.plasma6.excludePackages = with pkgs.kdePackages; [
  #   elisa            # player muzică
  #   khelpcenter
  #   kdepim-runtime
  # ];

  fonts.packages = with pkgs; [
    inter
    nerd-fonts.jetbrains-mono
  ];

  # ─────────────────────────────────────
  # NVIDIA
  # ─────────────────────────────────────
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
  };

  # ─────────────────────────────────────
  # ENV VARS (NVIDIA + Wayland)
  # ─────────────────────────────────────
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # WLR_NO_HARDWARE_CURSORS era pt. wlroots/Hyprland — KWin îl ignoră, l-am scos.
  };

  # ─────────────────────────────────────
  # STATE VERSION
  # ─────────────────────────────────────
  system.stateVersion = "25.11";
}
