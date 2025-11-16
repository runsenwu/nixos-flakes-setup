{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    ./setups/default.nix

    # maybe in the future when the next version becomes stable instead
    #inputs.niri.homeModules.niri
    #inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  # basic settings
  home.username = "mega_wu";
  home.homeDirectory = "/home/mega_wu";
  home.stateVersion = "25.05";

  # enabling
  programs.dankMaterialShell = {
    enable = true;
    quickshell.package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.quickshell;
    #niri = {
    #  enableKeybinds = true;
    #  enableSpawn = true;
    #};
  };

  programs.git.enable = true;

  home.packages = with pkgs; [
    neofetch

    # this is for vivaldi
    kdePackages.qtwayland

    # other apps
    obsidian
  ];

  # This is for other things
  #
  #  xdg.configFile = builtins.mapAttrs
  # (name: subpath: {
  #   source = create_symlink "&{dotfiles}/${subpath}";
  #   recursive = true;
  # })
  # configs;
  # home.file.".config/hypr".source = ./config/hypr;
  # home.file.".config/waybar".source = ./config/waybar;
  #
  # let
  #   dotfiles = "${config.home.homeDirectory}/nixos-version-control/nix-config";
  #   create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  #   configs = {
  #     hypr = "hypr";
  #     waybar = "waybar";
  #   };
  # in

  home.file.".config/niri".source = ./setups/base/display/niri;
}
