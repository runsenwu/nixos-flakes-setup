{ config, pkgs, ... }:
{
  programs.vivaldi = {
    enable = true;
    commandLineArgs = [ "--ozone-platform=wayland" ];
  };
}
