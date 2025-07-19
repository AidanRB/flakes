{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix # impure
    ./UEFI.nix
  ];

  networking.hostName = "greenkeys"; # Define your hostname.

  services = {
    printing.enable = true;

    xserver.videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  system.stateVersion = "22.05";
}
