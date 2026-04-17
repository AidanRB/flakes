{ pkgs, inputs, ... }:

{
  system.activationScripts.copyConfig = {
    text = ''
      ${pkgs.rsync}/bin/rsync -r --chmod=Du=rwx,Dgo=rx,Fu=rw,Fgo=r --chown=aidan:users ${./aidan.config}/ /home/aidan/.config/
    '';
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  users.users.aidan.packages = with pkgs; [
    playerctl
    hyprsunset
    hyprpaper
    gpu-screen-recorder
    walker
    elephant
    wiremix
    waybar
    swaynotificationcenter
    file-roller
  ];

  programs = {
    hyprlock.enable = true;
  };

  services = {
    playerctld.enable = true;
    hypridle.enable = true;
    # elephant.enable = true; # seems to have $PATH issues, missing commands
  };

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.symbols-only
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
