{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  users.users.aidan.packages = with pkgs; [
    walker
    playerctl
  ];

  programs.waybar.enable = true;

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