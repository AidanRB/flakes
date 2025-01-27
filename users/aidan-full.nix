{ pkgs, ... }:

{
  imports = [
    ./aidan.nix
  ];

  users.users.aidan.packages = with pkgs; [
    # games
    prismlauncher
    gamehub
    osu-lazer-bin

    vscode-fhs
    nixfmt-rfc-style
    helvum
    nmap
    nextcloud-client
    qownnotes
    xournalpp
    libreoffice
    vlc
  ];

  programs.steam.enable = true;
}
