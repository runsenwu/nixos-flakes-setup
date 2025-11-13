{ pkgs, lib, ... }:

{
  imports = [
    ./starship.nix
    # ./starship_full.nix
  ];
  # Handy CLI set (trim to taste)
  home.packages = with pkgs; [
    # lsd
    bat
    ripgrep
    fd
    fzf
    tree
    unzip
    zip
    wget
    curl
    git
    zoxide
  ];

  # Nushell
  programs.nushell = {
    enable = true;

    # ---- Starship prompt (Nu integration) ----
    # $env.STARSHIP_SHELL = "nu"
    # use ~/.cache/starship/init.nu *
    # Minimal, sane prompt + completions
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }

      $env.config = ($env.config | default {} | merge {
        show_banner: false
        edit_mode: "emacs"          # change to "vi" if you prefer
        render_right_prompt_on_last_line: true
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
          external: { enable: true, max_results: 20, completer: $carapace_completer }
        }
      })

      def --env mkcd [path] { mkdir $path; cd $path }
    '';
  };

  # Prompt, completions, per-dir env, jump-to-dir
  # programs.starship = {
  #   enable = true;
  #   enableNushellIntegration = true;
  #   settings = {
  #     add_newline = true;
  #     character = {
  #       success_symbol = "➜";
  #       error_symbol = "✗";
  #     };
  #     git_status = {
  #       conflicted = "=";
  #       ahead = "⇡";
  #       behind = "⇣";
  #       diverged = "⇕";
  #       untracked = "?";
  #       stashed = "$";
  #       modified = "!";
  #       staged = "+";
  #       renamed = "»";
  #       deleted = "✘";
  #     };
  #   };
  # };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.yazi.enable = true;

  home.file."/.config/yazi/yazi.toml".text = ''
    [opener]
    edit = [
      { run = "hx \"$@\"", block = true, desc = "Edit in Helix" }
    ]
    open = [
      { run = "hx \"$@\"", block = true, desc = "Open in Helix" }
    ]

    # NEW: prepend_rules must be an array of tables ([[ ... ]])
    [[open.prepend_rules]]
    name = "*.nix"
    use  = ["edit"]

    # NEW: [manager] was renamed to [mgr]
    [mgr]
    show_hidden = true
  '';

  # keymap.toml: layer renamed from [manager] -> [mgr]
  home.file."/.config/yazi/keymap.toml".text = ''
    [mgr]
    "E" = "open --with edit"   # Shift+E to open with the "edit" opener (Helix)
  '';
}
