{
  description = "Configuration for some NixOS computers";

  inputs = {
    # Add nixpkgs unstable as the default source for packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: {

    nixosConfigurations = {
      F09N0F3 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./F09N0F3/configuration.nix
          ./desktops/gnome.nix
          ./users/aidan.nix
          ./general/common.nix
        ];
      };
    };
  };
}
