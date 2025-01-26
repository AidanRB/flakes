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
    speedcrunch
    flameshot
    helvum
    nmap
    nextcloud-client
    qownnotes
  ];
}
