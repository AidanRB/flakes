{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix # impure
    ./UEFI.nix
  ];

  networking.hostName = "hpbook"; # Define your hostname.

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

  system.stateVersion = "23.05";
}
