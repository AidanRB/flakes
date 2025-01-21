{ lib, pkgs }:
{
  users.users.aidan = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # games
      prismlauncher
      gamehub

      brave
      discord
      vscode
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  programs.steam.enable = true;
}