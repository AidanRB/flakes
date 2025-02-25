{ pkgs, ... }:

{
  imports = [
    ./reuben.nix
  ];

  users.users.reuben.packages = with pkgs; [
    # web
    firefox
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