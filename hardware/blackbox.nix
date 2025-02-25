{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
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
  swapDevices = [ { device = "/swap/swapfile"; } ];

  boot = {
    # hibernation
    kernelParams = [ "resume_offset=13116672" ];
    resumeDevice = "/dev/nvme0n1p5";
  };

  # hibernate after 30m asleep in suspend-then-hibernate
  systemd.sleep.extraConfig = "HibernateDelaySec=30m";

  networking = {
    hostName = "blackbox"; # Define your hostname.

    firewall = {
      # 4567 general
      # 7777 terraria
      # 25565/8123 minecraft/dynmap
      allowedTCPPorts = [
        4567
        7777
        25565
        8123
      ];
      allowedUDPPorts = [
        4567
        7777
        25565
        8123
      ];
    };
  };

  users.users.aidan.packages = with pkgs; [
    # games
    gamehub
    kdePackages.granatier

    # multimedia
    spotify
    kdenlive
    mediainfo
    obs-studio

    # web
    google-chrome
    firefox
    thunderbird

    # tools
    appeditor
    qflipper
    dig
    gcolor3

    # astra monitor
    pciutils
    amdgpu_top
    easyeffects
    piper
  ];

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    ollama = {
      enable = true;
      loadModels = [
        "deepseek-r1:8b"
        "qwen2.5-coder:1.5b"
      ];
    };

    # self-hosted chatgpt
    # open-webui.enable = true;

    tailscale.enable = true;
    openssh.enable = true;

    # hardware support
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
    ratbagd.enable = true;
  };

  system.stateVersion = "23.11";
}
