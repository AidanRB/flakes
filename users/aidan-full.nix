{ pkgs, ... }:

{
  imports = [
    ./aidan-gui.nix
  ];

  users.users.aidan.packages = with pkgs; [
    # games
    prismlauncher
    osu-lazer-bin
    lutris

    vscode-fhs
    nixfmt
    crosspipe
    nmap
    nextcloud-client
    qownnotes
    xournalpp
    libreoffice
    vlc
    resources
    remmina
    bluebubbles
    blender
    # openscad-unstable
  ];

  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };

    virt-manager.enable = true;
  };
}
