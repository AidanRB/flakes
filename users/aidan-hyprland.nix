{ pkgs, ... }:

{
  # imports = [walker.nixosModules.default];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  users.users.aidan.packages = with pkgs; [
    walker
    playerctl
    hyprpaper
    gpu-screen-recorder
  ];

  programs = {
    waybar.enable = true;
    walker.enable = true;
    hyprlock.enable = true;
  };

  services = {
    playerctld.enable = true;
    hypridle.enable = true;
  };

  fonts.packages = with pkgs; [
    font-awesome
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  home-manager.users.aidan = {
    wayland.windowManager.hyprland.plugins = with pkgs; [
      hyprlandPlugins.hyprexpo
    ];
  };
}