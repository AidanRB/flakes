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
      vscode
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
}