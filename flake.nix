{
  description = "NixOS configuration - zaha";

  inputs = {
    # nixpkgs stable 25.11
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Home Manager - trebuie să folosească același nixpkgs
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.zaha = import ./home.nix;
          }
        ];
      };
    };
}
