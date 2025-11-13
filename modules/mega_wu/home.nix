{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  dotfiles = "${config.home.homeDirectory}/nixos-version-control/nix-config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    waybar = "waybar";
  };
in

{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    ../essentials/terminal/shells/nushell/nu-stack.nix
    ../essentials/coding-languages/rust/rust.nix
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
  # programs.quickshell.enable = true;

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "Gruvbox Dark Hard";
      };
      hour_format = "hour24";
      vim_mode = false;
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = ''echo "check check"'';
    };
  };

  home.shellAliases = {
    # modern replacements
    la = "ls -a";
    ll = "ls -l";
    cat = "bat";
    find = "fd";
    grep = "rg";

    # git
    g = "git";
    ga = "git add";
    gc = "git commit";
    gca = "git commit --amend";
    gpsh = "git push";
    gpul = "git pull";
    gst = "git status";
    gco = "git checkout";
    gb = "git branch";
    gbb = "git branch -b";
    gd = "git diff";
    glg = "git log --graph --decorate --oneline --all";

    # nav + zoxide
    z = "z";
    zz = "z -r";
    ".." = "cd ..";
    "..." = "cd ../..";

    # yazi
    yz = "yazi";

    # archives
    untar = "tar -xvf";
    targz = "tar -czvf";

    # misc
    # path = "echo $env.PATH | tr ':' '\\n'";
    nrsf = "sudo nixos-rebuild switch --flake .#nixos";

    zd = "zeditor";
  };

  programs.vivaldi = {
    enable = true;
    commandLineArgs = [ "--ozone-platform=wayland" ];
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "bar";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
      {
        name = "rust";
        auto-format = true;
        formatter.command = lib.getExe pkgs.rust-analyzer;
      }
      {
        name = "c-sharp";
        auto-format = true;
        formatter.command = lib.getExe pkgs.omnisharp-roslyn;
      }
    ];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };

  home.packages = with pkgs; [
    neofetch

    # this is for vivaldi
    kdePackages.qtwayland

    # other apps
    obsidian

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
  home.file.".config/niri".source = ../essentials/display/niri;
}
