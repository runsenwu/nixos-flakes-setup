{ pkgs, lib, ... }:
{
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = ''echo "check check"'';
    };
  };
}
