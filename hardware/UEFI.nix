{ lib, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    timeout = lib.mkDefault 0;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}