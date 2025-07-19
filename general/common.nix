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
    operation = "boot";
    flake = "github:aidanrb/flakes";
    flags = [
      "--no-write-lock-file"
      "--impure"
      "--option"
      "tarball-ttl"
      "0"
    ];
  };

  boot = {
    supportedFilesystems = [ "ntfs" ];

    # enable hibernation
    initrd.systemd.enable = true;

    # boot animation
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = [
        pkgs.nixos-bgrt-plymouth
      ];
    };
    kernelParams = [
      "quiet"
      "splash"
    ];
  };

  # Set your time zone.
  time = {
    timeZone = "America/New_York";
    hardwareClockInLocalTime = true;
  };

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs [term]
  environment.systemPackages = with pkgs; [
    micro
    xclip
    git
    bat
    eza
  ];

  programs = {
    fish.enable = true;
    command-not-found.enable = true;
  };

  environment.shellAliases = {
    ip = "ip --color=auto";
  };
}

