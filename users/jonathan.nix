{ pkgs, ... }:

{
  users.users.jonathan = {
    isNormalUser = true;
    description = "Jonathan Bennett";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [

    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
