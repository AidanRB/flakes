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

in

{
  users.users.aidan.packages = with pkgs; [
    gnomeExtensions.gsconnect
  ];

  programs.kdeconnect.package = pkgs.gnomeExtensions.gsconnect;

  home-manager.users.aidan = {
    programs = {
      gnome-shell = {
        enable = true;
        extensions = [
          { package = pkgs.gnomeExtensions.appindicator; }
          { package = pkgs.gnomeExtensions.alphabetical-app-grid; }
          { package = pkgs.gnomeExtensions.astra-monitor; }
          { package = pkgs.gnomeExtensions.brightness-control-using-ddcutil; }
          { package = pkgs.gnomeExtensions.caffeine; }
          { package = pkgs.gnomeExtensions.clipboard-indicator; }
          { package = pkgs.gnomeExtensions.grand-theft-focus; }
          { package = pkgs.gnomeExtensions.gsconnect; }
          { package = pkgs.gnomeExtensions.hibernate-status-button; }
          { package = pkgs.gnomeExtensions.removable-drive-menu; }
          { package = pkgs.gnomeExtensions.quick-settings-audio-devices-hider; }
          { package = pkgs.gnomeExtensions.quick-settings-audio-devices-renamer; }
          { package = pkgs.gnomeExtensions.quick-settings-audio-panel; }
          { package = pkgs.gnomeExtensions.systemd-status; }
          { package = pkgs.gnomeExtensions.tailscale-status; }
          { package = pkgs.gnomeExtensions.tiling-assistant; }
        ];
      };
    };

    gtk = {
      enable = true;

      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
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

      # Extension preferences
      "org/gnome/shell/extensions/clipboard-indicator".toggle-menu = "['<Super>v']";
      "org/gnome/shell/extensions/display-brightness-ddcutil" = {
        button-location = 1;
        hide-system-indicator = true;
      };
      "org/gnome/shell/extensions/hibernate-status-button".show-hybrid-sleep = false;
      "org/gnome/shell/extensions/tiling-assistant" = {
        enable-tiling-popup = false;
        enable-raise-tile-group = false;
      };
    };
  };
}
