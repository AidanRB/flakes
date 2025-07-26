{ pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ./UEFI.nix
  ];

  environment.gnome.excludePackages = [];

  networking.hostName = "gnomebook";

  documentation.nixos.enable = false;

  services = {
    flatpak.enable = true;

    printing.enable = true;

    tailscale.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome-tweaks
      micro
      xclip
      git
    ];

    shellAliases = {
      l = "ls --color --classify";
      la = "--color --classify --almost-all";
      ll = "--color --classify -l --all --human-readable";
    };
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    password = "password";
  };

  system.stateVersion = "25.11";
}
