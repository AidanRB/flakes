{ pkgs, ... }:

{
  imports = [
    ./aidan-gui.nix
  ];

  users.users.aidan.packages = with pkgs; [
    # games
    prismlauncher
    gamehub
    osu-lazer-bin
    lutris

    vscode-fhs
    nixfmt-rfc-style
    helvum
    nmap
    nextcloud-client
    qownnotes
    xournalpp
    libreoffice
    vlc
    resources
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
