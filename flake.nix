{
  description = "Configuration for some NixOS computers";

  inputs = {
    # Add nixpkgs unstable as the default source for packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager }: {

    nixosConfigurations = {
      F09N0F3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/F09N0F3/configuration.nix
          ./desktops/gnome.nix
          home-manager.nixosModules.home-manager
          ./users/aidan.nix
          ./general/common.nix
        ];
      };

      BHZ8VC3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware/BHZ8VC3/configuration.nix
          ./desktops/gnome.nix
          ./users/reuben.nix
          ./general/common.nix
        ];
      };
    };
  };
}
