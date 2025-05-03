{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix # impure
    ./UEFI.nix
  ];

  networking.hostName = "fractured"; # Define your hostname.

  services = {
    printing.enable = true;
    openssh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-builder
  ];

  # for arduino cloud agent
  programs.nix-ld.enable = true;

  # super tux kart server
  networking.firewall.allowedTCPPorts = [ 30000 2757 2759 ];
  networking.firewall.allowedUDPPorts = [ 30000 2757 2759 ];

  system.stateVersion = "23.11";
}
