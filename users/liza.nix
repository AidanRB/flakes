{ pkgs, ... }:

{
  users.users.liza = {
    isNormalUser = true;
    description = "Elizabeth Bennett";
    extraGroups = [
      "networkmanager"
    ];
    packages = with pkgs; [
      brave
      google-chrome
      flameshot

      gnome-mines
      kdePackages.granatier
      pingus
      prismlauncher
      steam-run
      superTux
      superTuxKart
    ];
  };
}
