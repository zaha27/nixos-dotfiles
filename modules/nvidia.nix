{ ... }:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = false;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL               = "1";
    GBM_BACKEND                  = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME    = "nvidia";
    NVD_BACKEND                  = "direct";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    __GL_GSYNC_ALLOWED           = "1";
    __GL_VRR_ALLOWED             = "1";
  };
}
