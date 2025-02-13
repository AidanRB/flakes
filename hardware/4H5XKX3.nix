# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./UEFI.nix
    ];

  fileSystems = {
  	"/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
  };

  networking.hostName = "4H5XKX3"; # Define your hostname.

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  users.users.aidan.packages = with pkgs; [
    vscode-fhs
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}

