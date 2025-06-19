{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix # impure
      ../UEFI.nix
    ];

  networking.hostName = "BHZ8VC3"; # Define your hostname.

  services = {
    printing.enable = true;

    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
  };

  system.stateVersion = "24.05";
}

