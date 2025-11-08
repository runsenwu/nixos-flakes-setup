{ config, pkgs, ... }:
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
  home.username = "mega_wu";
  home.homeDirectory = "/home/mega_wu";
  programs.git.enable = true;
  home.stateVersion = "25.05";
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

  home.packages = with pkgs; [
    neofetch
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
