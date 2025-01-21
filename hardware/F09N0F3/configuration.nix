{ ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../UEFI.nix
    ];

  networking.hostName = "F09N0F3"; # Define your hostname.

  services.printing.enable = true;

  system.stateVersion = "24.11";
}

