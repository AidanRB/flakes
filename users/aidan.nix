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
  users.users.aidan = {
    isNormalUser = true;
    description = "Aidan Bennett";
    extraGroups = [
      "networkmanager"
      "wheel"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      brave
      discord-canary
      ghostty

      speedcrunch
      flameshot
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment = {
    shellAliases = {
      l = "eza --icons --classify=always";
      ls = "eza --icons --classify=always";
      la = "eza --icons --classify=always --all";
      ll = "eza --icons --classify=always --long --all --group --mounts --git --extended";
      tree = "eza --icons --classify=always --tree";
    };
  };

  home-manager = {
    backupFileExtension = ".old";

    users.aidan = {
      programs = {
        fish = {
          enable = true;

          functions = {
            nix-shell = "command nix-shell --run fish $argv";

            fish_prompt = {
              body = ''
                set -l last_pipestatus $pipestatus
                set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
                set -l normal (set_color normal)
                set -q fish_color_status
                or set -g fish_color_status --background=red white

                # Color the prompt differently when we're root
                set -l color_cwd $fish_color_cwd
                set -l suffix '>'
                if functions -q fish_is_root_user; and fish_is_root_user
                    if set -q fish_color_cwd_root
                        set color_cwd $fish_color_cwd_root
                    end
                    set suffix '#'
                end

                # Write pipestatus
                # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
                set -l bold_flag --bold
                set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
                if test $__fish_prompt_status_generation = $status_generation
                    set bold_flag
                end
                set __fish_prompt_status_generation $status_generation
                set -l status_color (set_color $fish_color_status)
                set -l statusb_color (set_color $bold_flag $fish_color_status)
                set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

                # add nix-shell info
                if test -n "$IN_NIX_SHELL"
                  set_color bryellow
                  echo -n "<nix-shell> "
                end

                echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd --full-length-dirs 1) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
              '';
            };
          };
        };

        ghostty = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            theme = "kgx";
            font-family = "Source Code Pro";
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

        sessionVariables = {
          EDITOR = "micro";
          VISUAL = "micro";
          fish_greeting = "";
        };

        stateVersion = "24.11";
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
            "discord-canary.desktop"
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
    };
  };
}
