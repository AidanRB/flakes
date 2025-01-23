{ pkgs, ... }:

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
      "/org/gnome/settings-daemon/plugins/media-keys/" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
        ];

        "custom-keybindings/custom0" = {
          binding = "<Super>t";
          command = "kgx";
          name = "console";
        };

        "custom-keybindings/custom1" = {
          binding = "Print";
          command = "bash -c \"flameshot gui > /dev/null\"";
          name = "flameshot";
        };

        "custom-keybindings/custom2" = {
          binding = "<Super>c";
          command = "speedcrunch";
          name = "speedcrunch";
        };

        "custom-keybindings/custom3" = {
          binding = "<Super>d";
          command = "/home/aidan/Documents/code/toggle_dnd";
          name = "toggle_dnd";
        };
      };
    };
  };
}
