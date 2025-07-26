{ pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Remove packages I don't want
  environment.gnome.excludePackages = lib.mkDefault (with pkgs; [
    gnome-tour
    gnome-photos
    epiphany
    geary
    gnome-maps
    gnome-music
  ]);

  # Allow installing extensions
  services.gnome.gnome-browser-connector.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    ddcutil
  ];
}