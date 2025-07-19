{ pkgs, ... }:

{
  users.users.aidan = {
    isNormalUser = true;
    description = "Aidan Bennett";
    extraGroups = [
      "wheel"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWlqFWcRu5SYJN+aXPZC4JvL1TrkP05D1duF2QH+ofX"
    ];
  };

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
      };

      home = {
        sessionVariables = {
          EDITOR = "micro";
          VISUAL = "micro";
          fish_greeting = "";
          BAT_PAGER = "less --mouse";
          # https://github.com/sharkdp/bat?tab=readme-ov-file#man
          MANPAGER = "sh -c 'col -bx | bat -l man -p'";
          MANROFFOPT = "-c";
          SYSTEMD_PAGER = "bat -l syslog -p --strip-ansi=auto";
          SYSTEMD_PAGERSECURE = "false";
        };

        stateVersion = "24.11";
      };
    };
  };
}
