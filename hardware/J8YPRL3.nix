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

  networking.hostName = "J8YPRL3"; # Define your hostname.

  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    fprintd = {
      enable =  true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-broadcom;
      };
    };

    intune.enable = true;
  };

  users.users.aidan.packages = with pkgs; [
    intune-portal
  ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # systemd.services.NetworkManager-wait-online.enable = false;

  # # Router
  # boot.kernel.sysctl."net.ipv4.conf.all.forwarding" = true;
  # boot.kernel.sysctl."net.ipv6.conf.all.forwarding" = true;
  # networking.firewall.enable = false;
  # networking = {
  #   nat = {
  #     enable = true;
  #     internalInterfaces = [ "enp0s13f0u1u4" ];
  #     internalIPs = [ "10.0.0.0/24" ];
  #     externalInterface = "wlp0s20f3";
  #   };
  #   interfaces.enp0s13f0u1u4.ipv4.addresses = [ {
  #     address = "10.0.0.1";
  #     prefixLength = 24;
  #   } ];
  #   networkmanager.unmanaged = [ "enp0s13f0u1u4" ];
  # };
  #
  # services.dnsmasq = {
  #   enable = true;
  #   settings = {
  #     server = [ "1.1.1.1" "8.8.8.8" ];
  #     domain-needed = true;
  #     bogus-priv = true;
  #     no-resolv = true;
  #
  #     dhcp-range = [ "enp0s13f0u1u4,10.0.0.100,10.0.0.200,24h" ];
  #     interface = "enp0s13f0u1u4";
  #     dhcp-host = "10.0.0.1";
  #   };
  # };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
