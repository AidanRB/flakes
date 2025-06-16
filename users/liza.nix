{ pkgs, ... }:

{
  users.users.liza = {
    isNormalUser = true;
    description = "Elizabeth Bennett";
    hashedPassword = "$y$j9T$FEpQnkY0kxAo4GeuJxv5L1$Pmi/Xe6f7zBKzE4Gb1LOnCaW0FMJZE8.k8IDDd3qSg1";
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
