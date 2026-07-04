{ pkgs, ... }:

{
  users.users.elena = {
    isNormalUser = true;
    description = "Elena Bennett";
    extraGroups = [
      "networkmanager"
    ];
    packages = with pkgs; [
      google-chrome
      flameshot
      firefox
      spotify
      discord
      vlc

      gnome-mines
      kdePackages.granatier
      pingus
      prismlauncher
      steam-run
      superTux
      superTuxKart
      sgt-puzzles
      kobodeluxe
      zaz
      lbreakout2
      
    ];
  };

  services.gnome.games.enable = true;
}
