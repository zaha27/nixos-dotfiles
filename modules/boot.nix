{ ... }:

{
  boot.loader.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.limine = {
    enable = true;
    style = {
      wallpapers = [ ../assets/wallpaper-limine-blur.jpg ];
      wallpaperStyle = "stretched";
      backdrop = "000000";
    };
    extraEntries = ''
      /Windows 11
        protocol: efi_chainload
        image_path: guid(5186fbe0-eea6-47f3-b926-6f1ba8557b49):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  fileSystems."/boot/efi-windows" = {
    device = "/dev/disk/by-uuid/000A-90C6";
    fsType = "vfat";
    options = [ "ro" "nofail" "umask=0077" ];
  };
}
