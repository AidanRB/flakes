{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  users.users.aidan.packages = with pkgs; [
    wofi
  ];

  programs.waybar.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}