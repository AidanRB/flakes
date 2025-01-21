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
      "--option"
      "tarball-ttl"
      "0"
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs [term]
  environment.systemPackages = with pkgs; [
    micro
    git
  ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

