{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-version-control/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
   # helix = "helix";
    hypr = "hypr";
    waybar = "waybar";
  };
in

{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default

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
     quickshell.package =
       inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.quickshell;
     #niri = {
     #  enableKeybinds = true;
     #  enableSpawn = true;
     #};
  };
  
  programs.git.enable = true;
  # programs.quickshell.enable = true;  

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = ''echo "check check"'';
      nrsf = "sudo nixos-rebuild switch --flake .#nixos";
     };
    # profileExtra = ''
    #     if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    #       exec uwsm start -S hyprland-uwsm.desktop
    #     fi
    # '';
  };

  programs.vivaldi =  {
    enable = true;
    commandLineArgs = ["--ozone-platform=wayland"];
  };
 
  # home.sessionVariables = {
  #   # this is for vivaldi to launch correctly
  #   CHROMIUM_FLAGS = "--ozone-platform=wayland --enable-features=UseOzonePlatform,WaylandWindowDecorations";
  # };



  home.packages = with pkgs; [
    neofetch
    
    # vivaldi stuff
    # (vivaldi.override {
    #   proprietaryCodecs = true;
    #   enableWidevine = true;
    # }).overrideAttrs (oldAttrs: {
    #   commandLineArgs = [
    #     "--ozone-platform=wayland"
    #     # Optional, might help depending on your setup
    #     "--enable-features=UseOzonePlatform" 
    #     "--ozone-platform-hint=auto"
    #   ];
    # })
    kdePackages.qtwayland

    # this is for running ns for nix-search TV
    (pkgs.writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];
      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
    })
  ];

  # xdg.configFile = builtins.mapAttrs
  # (name: subpath: {
  #   source = create_symlink "&{dotfiles}/${subpath}";
  #   recursive = true;
  # })
  # configs;
  # home.file.".config/hypr".source = ./config/hypr;
  # home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/niri".source = ./config/niri; 
}
