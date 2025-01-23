{ pkgs, ... }:

let

  toggleDND = pkgs.writeTextFile {
    name = "toggleDND";
    text = ''
      #!/usr/bin/env bash

      value=$(gsettings get org.gnome.desktop.notifications show-banners)
      if [[ $value == 'true' ]]
      then
        gsettings set org.gnome.desktop.notifications show-banners false
      else
        gsettings set org.gnome.desktop.notifications show-banners true
      fi
    '';
    executable = true;
  };

in

{
  users.users.aidan = {
    isNormalUser = true;
    description = "Aidan Bennett";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # games
      prismlauncher
      gamehub
      osu-lazer-bin

      brave
      discord
      vscode-fhs
      nixfmt-rfc-style
      bibata-cursors
      speedcrunch
      flameshot
      helvum
      nmap
      nextcloud-client
      qownnotes
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.steam.enable = true;

  environment.variables = {
    EDITOR = "micro";
    VISUAL = "micro";
  };

  home-manager.users.aidan = {
    dconf.settings = {
      # Pinned apps
      "org/gnome/shell" = {
        favorite-apps = [
          "brave-browser.desktop"
          "org.gnome.Nautilus.desktop"
          "discord.desktop"
          "steam.desktop"
        ];
      };

      # Custom keybinds
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "kgx";
        name = "console";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "Print";
        command = "bash -c \"flameshot gui > /dev/null\"";
        name = "flameshot";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Super>c";
        command = "speedcrunch";
        name = "speedcrunch";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        binding = "<Super>d";
        command = "${toggleDND}";
        name = "toggle_dnd";
      };
    };

    home.stateVersion = "24.11";
  };
}
