{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../UEFI.nix
    ];

  networking.hostName = "BHZ8VC3"; # Define your hostname.

  system.stateVersion = "24.05";
}

