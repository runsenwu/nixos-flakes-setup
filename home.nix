{ config, pkgs, ... }:

{
  home.username = "mega_wu";
  home.homeDirectory = "/home/mega_wu";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "check check";
    };
  };
}
