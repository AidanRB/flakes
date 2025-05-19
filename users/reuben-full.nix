{ pkgs, ... }:

{
  imports = [
    ./reuben.nix
  ];

  programs.firefox.enable = true;

  users.users.reuben.packages = with pkgs; [
    # web
    google-chrome

    # games
    superTux
    superTuxKart
    pingus
    kdePackages.granatier
    gnome-mines
    steam-run # terraria

    vlc
    arduino-create-agent
    nixfmt-rfc-style
  ];
}