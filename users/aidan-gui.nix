{ pkgs, ... }:

{
  imports = [
    ./aidan.nix
  ];

  users.users.aidan = {
    extraGroups = [
      "networkmanager"
    ];
    packages = with pkgs; [
      brave
      discord
      ghostty

      speedcrunch
      flameshot
      bitwarden-desktop

      dm-mono
    ];
  };

  programs.kdeconnect.enable = true;

  home-manager.users.aidan = {
    programs = {
      ghostty = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          theme = "kgx";
          font-family = "DM Mono";
          font-size = 10;
          window-padding-x = 6;
          gtk-single-instance = true;
          scrollback-limit = 100000000;
        };
        themes = {
          kgx = {
            background = "1f1f1f";
            cursor-color = "ffffff";
            foreground = "ffffff";
            palette = [
              "0=#241f31"
              "1=#c01c28"
              "2=#2ec27e"
              "3=#f5c211"
              "4=#1e78e4"
              "5=#9841bb"
              "6=#0ab9dc"
              "7=#c0bfbc"
              "8=#5e5c64"
              "9=#ed333b"
              "10=#57e389"
              "11=#f8e45c"
              "12=#51a1ff"
              "13=#c061cb"
              "14=#4fd2fd"
              "15=#f6f5f4"
            ];
            selection-invert-fg-bg = true;
          };
        };
      };
    };

    home = {
      keyboard.options = [ "compose:caps" ];
      shell.enableFishIntegration = true;
      sessionVariables = {
        SSH_AUTH_SOCK = "/home/aidan/.bitwarden-ssh-agent.sock";
      };
    };

    xdg.autostart = {
      enable = true;
      entries = [
        "${pkgs.bitwarden-desktop}/share/applications/bitwarden.desktop"
      ];
    };
  };
}
