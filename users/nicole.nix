{ pkgs, ... }:

{
  users.users.nicole = {
    isNormalUser = true;
    description = "Nicole Bennett";
    extraGroups = [
      "networkmanager"
    ];
    packages = with pkgs; [
      # web
      brave
      google-chrome
      firefox
    ];
  };
}
