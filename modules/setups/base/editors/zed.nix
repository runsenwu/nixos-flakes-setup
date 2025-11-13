{ pkgs, lib, ... }:
{
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
}
