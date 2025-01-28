{
  description = "Configuration for some NixOS computers";

  inputs = {
    # Add nixpkgs unstable as the default source for packages
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # reuben = {
    #   url = "github:rtbennett/flakes";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      # reuben,
    }:
    {

      nixosConfigurations = {
        F09N0F3 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware/F09N0F3/configuration.nix
            ./desktops/gnome.nix
            home-manager.nixosModules.home-manager
            ./users/aidan-full.nix
            ./general/common.nix
          ];
        };

        BHZ8VC3 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware/BHZ8VC3/configuration.nix
            ./desktops/gnome.nix
            ./users/reuben.nix
            # reuben.BHZ8VC3
            ./general/common.nix
          ];
        };

        J8YPRL3 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware/J8YPRL3.nix
            ./desktops/gnome.nix
            home-manager.nixosModules.home-manager
            ./users/aidan.nix
            ./general/common.nix
          ];
        };

        blackbox = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hardware/blackbox.nix
            ./desktops/gnome.nix
            home-manager.nixosModules.home-manager
            ./users/aidan-full.nix
            ./general/common.nix
          ];
        };
      };
    };
}
