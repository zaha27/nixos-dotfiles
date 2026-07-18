{ ... }:

{
  users.users.zaha = {
    isNormalUser = true;
    description = "Andrei";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
