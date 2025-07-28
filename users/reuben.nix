{ pkgs, ... }:

{
  users.users.reuben = {
    isNormalUser = true;
    description = "Reuben Bennett";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      # games
      prismlauncher

      brave
      discord
      vscode-fhs
      flameshot
      blender
      ente-auth
      sshfs
      android-tools
      scrcpy
      speedcrunch
      vlc
    ];
    shell = pkgs.fish;
  };

  programs.steam.enable = true;

  home-manager = {
    backupFileExtension = ".old";

    users.reuben = {
      gtk = {
        enable = true;
        cursorTheme = {
          name = "Bibata-Modern-Classic";
          package = pkgs.bibata-cursors;
        };
      };
      home = {
        keyboard.options = [ "compose:caps" ];
        stateVersion = "24.11";
      };
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
      };
    };
  };
}
