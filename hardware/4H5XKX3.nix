{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./UEFI.nix
  ];

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
  };

  networking.hostName = "_4H5XKX3";

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-broadcom;
      };
    };
  };

  users.users.aidan.packages = with pkgs; [
    vscode-fhs
  ];

  system.stateVersion = "25.05";
}
