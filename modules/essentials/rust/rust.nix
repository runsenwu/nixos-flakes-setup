# home.nix
{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.rustup
    pkgs.pkg-config # useful when building native deps
    pkgs.openssl # common native dep (add .dev if you package things)
  ];

  # Optional: keep these in standard places; hm will export PATH automatically.
  home.sessionVariables = {
    CARGO_HOME = "${config.home.homeDirectory}/.cargo";
    RUSTUP_HOME = "${config.home.homeDirectory}/.rustup";
  };
}
