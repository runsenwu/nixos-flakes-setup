{ pkgs, lib, ... }:
{
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
}
