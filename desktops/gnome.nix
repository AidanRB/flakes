{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Remove packages I don't want
  environment.gnome.excludePackages = (with pkgs; [
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