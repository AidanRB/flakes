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

  inkWallpaper = pkgs.fetchurl {
    url = "https://images.unsplash.com/photo-1541701494587-cb58502866ab";
    name = "lucas-k-wQLAGv4_OYs-unsplash.jpg";
    hash = "sha256-qFD7FFqY2l2Fsev/YPu1/f7f29BntxsO1ezJj2BlMs8=";
  };

  stopGnomeSsh = pkgs.writeTextFile {
    name = "gnome-keyring-ssh.desktop";
    text = (builtins.readFile (pkgs.gnome-keyring + "/etc/xdg/autostart/gnome-keyring-ssh.desktop")) + ''
      Hidden=true
    '';
  };

in

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
      bitwarden

      gnomeExtensions.gsconnect

      dm-mono
    ];
  };

  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };

  home-manager = {
    users.aidan = {
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

      gtk = {
        enable = true;

        cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
        };
      };

      home = {
        keyboard.options = [ "compose:caps" ];
        shell.enableFishIntegration = true;
        sessionVariables = {
          SSH_AUTH_SOCK = "/home/aidan/.bitwarden-ssh-agent.sock";
        };
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "teal";
          clock-format = "12h";
          clock-show-weekday = true;
          show-battery-percentage = true;
        };

        # pointer acceleration off
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };

        # Wallpaper
        "org/gnome/desktop/background" = {
          picture-uri = "${inkWallpaper}";
          picture-uri-dark = "${inkWallpaper}";
        };

        # Pinned apps
        "org/gnome/shell" = {
          favorite-apps = [
            "brave-browser.desktop"
            "org.gnome.Nautilus.desktop"
            "discord.desktop"
            "steam.desktop"
          ];
        };

        "org/gnome/desktop/wm/preferences" = {
          action-middle-click-titlebar = "minimize";
        };

        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = [ ];
          switch-applications-backward = [ ];
          switch-windows = [ "<Alt>Tab" ];
          switch-windows-backward = [ "<Shift><Alt>Tab" ];
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
          command = "ghostty";
          name = "terminal";
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

      xdg.autostart = {
        enable = true;
        entries = [
          "${pkgs.bitwarden}/share/applications/bitwarden.desktop"
          stopGnomeSsh
        ];
      };
    };
  };
}
