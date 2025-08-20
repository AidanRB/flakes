{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NixOS";
      fsType = "ext4";
    };

    "/boot/efi" = {
      device = "/dev/disk/by-label/EFI\\x20System";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/var/lib/nextcloud" = {
      device = "/dev/disk/by-label/Data1";
      fsType = "btrfs";
      options = [ "subvol=nextcloud" ];
    };

    "/backup" = {
      device = "/dev/disk/by-label/Data1";
      fsType = "btrfs";
      options = [ "subvol=backup" ];
    };

    "/var/lib/immich" = {
      device = "/dev/disk/by-label/Data1";
      fsType = "btrfs";
      options = [ "subvol=immich" ];
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
