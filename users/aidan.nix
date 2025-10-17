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
    packages = with pkgs; [
      dig
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
                set -l prompt_status $status
                set -l retc red
                test $prompt_status = 0; and set retc green

                set -q __fish_git_prompt_showupstream
                or set -g __fish_git_prompt_showupstream auto

                function _nim_prompt_wrapper
                  set retc $argv[1]
                  set -l field_name $argv[2]
                  set -l field_value $argv[3]

                  set_color normal
                  set_color $retc
                  echo -n '─'
                  set_color -o green
                  echo -n '['
                  set_color normal
                  test -n $field_name
                  and echo -n $field_name:
                  set_color $retc
                  echo -n $field_value
                  set_color -o green
                  echo -n ']'
                end

                set_color $retc
                echo -n '╭─'
                set_color -o green
                echo -n [

                if functions -q fish_is_root_user; and fish_is_root_user
                  set_color -o red
                else
                  set_color -o yellow
                end

                echo -n $USER
                set_color -o white
                echo -n @

                if test -z "$SSH_CLIENT"
                  set_color -o blue
                else
                  set_color -o cyan
                end

                echo -n (prompt_hostname)
                set_color -o white
                echo -n :(prompt_pwd)
                set_color -o green
                echo -n ']'

                # nix-shell
                set -q IN_NIX_SHELL
                and echo -n '─['
                and set_color -o yellow
                and echo -n 'nix-shell'
                and set_color -o green
                and echo -n ']'

                # Date
                _nim_prompt_wrapper $retc "" (date +%X)

                # Virtual Environment
                set -q VIRTUAL_ENV_DISABLE_PROMPT
                or set -g VIRTUAL_ENV_DISABLE_PROMPT true
                set -q VIRTUAL_ENV
                and _nim_prompt_wrapper $retc V (path basename "$VIRTUAL_ENV")

                # git
                set -l prompt_git (fish_git_prompt '%s')
                test -n "$prompt_git"
                and _nim_prompt_wrapper $retc G $prompt_git

                # exit code
                if test $prompt_status != 0
                  set_color -o red
                  echo -n '─'
                  set_color -o green
                  echo -n '['
                  set_color -o red
                  echo -n "$prompt_status"
                  set_color -o green
                  echo -n ']'
                end

                # New line
                echo

                # Background jobs
                set_color normal

                for job in (jobs)
                  set_color $retc
                  echo -n '│ '
                  set_color brown
                  echo $job
                end

                set_color normal
                set_color $retc
                echo -n '╰─> '
                set_color normal
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
