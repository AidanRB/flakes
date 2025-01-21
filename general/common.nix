{ pkgs, ... }:

{
  # Enable flakes, set up automatic updates from GitHub, storage optimization
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = "github:aidanrb/flakes";
    flags = [
      "--no-write-lock-file"
      "--impure"
      "--option"
      "tarball-ttl"
      "0"
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs [term]
  environment.systemPackages = with pkgs; [
    micro
    git
      xclip
    bat
    eza
  ];

  environment.shellAliases = {
    ls = "eza -F";
    ll = "eza -F -l -a -g";
    l = "eza -F";
    la = "eza -F -a";
    ip = "ip --color=auto";
  };
}

