{ pkgs, lib, ... }:

{
  # Handy CLI set (trim to taste)
  home.packages = with pkgs; [
    lsd
    bat
    ripgrep
    fd
    fzf
    yazi
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
          external: { enable: true, max_results: 200, completer: $carapace_completer }
        }
      })

      def --env mkcd [path] { mkdir $path; cd $path }
    '';

    # shellAliases = {
    #   # modern replacements
    #   ls = "lsd -lh";
    #   la = "lsd -lha";
    #   ll = "lsd -lh";
    #   cat = "bat";
    #   find = "fd";
    #   grep = "rg";

    #   # git
    #   g = "git";
    #   ga = "git add";
    #   gc = "git commit";
    #   gca = "git commit --amend";
    #   gpsh = "git push";
    #   gpul = "git pull";
    #   gst = "git status";
    #   gco = "git checkout";
    #   gb = "git branch";
    #   gbb = "git branch -b";
    #   gd = "git diff";
    #   glg = "git log --graph --decorate --oneline --all";

    #   # nav + zoxide
    #   z = "z";
    #   zz = "z -r";

    #   # yazi
    #   yz = "yazi";

    #   # archives
    #   untar = "tar -xvf";
    #   targz = "tar -czvf";

    #   # misc
    #   path = "echo $env.PATH | tr ':' '\\n'";
    # };
  };

  # Prompt, completions, per-dir env, jump-to-dir
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = true;
      character = {
        success_symbol = "➜";
        error_symbol = "✗";
      };
      git_status = {
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };
    };
  };

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
}
