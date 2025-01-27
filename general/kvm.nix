{ pkgs, ... }:

{
  users.groups.libvirtd.members = [
    "aidan"
  ];

  environment.systemPackages = with pkgs; [
    spice-gtk
  ];

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;
}