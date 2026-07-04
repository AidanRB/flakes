{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./UEFI.nix
  ];

  networking.hostName = "ABF-GVGQMC2";

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

    printing.enable = true;
  };

  users.users.aidan.packages = with pkgs; [
    vscode-fhs
  ];

  system.stateVersion = "25.05";
}
