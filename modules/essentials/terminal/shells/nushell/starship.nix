{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;

    settings = {
      # ---------- Performance ----------
      command_timeout = 5000;
      scan_timeout = 1000;
      add_newline = true;

      # ---------- Layout ----------
      format = "$username$hostname$directory$git_branch$git_state$git_status$nix_shell$package$docker_context$kubernetes$nodejs$python$rust$golang$direnv$jobs$memory_usage$cmd_duration$status$line_break$character";
      right_format = "$time";

      # ---------- Palette ----------
      palettes.dev = {
        blue = "#7aa2f7";
        cyan = "#7dcfff";
        green = "#9ece6a";
        yellow = "#e0af68";
        red = "#f7768e";
        magenta = "#bb9af7";
        fgdim = "#a9b1d6";
        gray = "#565f89";
      };
      palette = "dev";

      # ---------- Prompt symbols ----------
      character = {
        success_symbol = "[➜](bold fg:green)";
        error_symbol = "[✗](bold fg:red)";
        vimcmd_symbol = "[](bold fg:magenta)";
      };

      # ---------- Identity ----------
      username = {
        show_always = false;
        style_user = "fg:fgdim";
      };
      hostname = {
        ssh_only = true;
        style = "fg:fgdim";
        format = "[@$hostname]($style) ";
      };

      # ---------- Directory ----------
      directory = {
        style = "bold fg:blue";
        truncation_length = 3;
        truncate_to_repo = true;
        repo_root_style = "bold fg:cyan";
        read_only = " ";
      };

      # ---------- Git ----------
      git_branch = {
        symbol = " ";
        style = "bold fg:magenta";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
      git_state = {
        style = "fg:yellow";
        format = "([$state( $progress_current/$progress_total)])($style) ";
      };
      git_status = {
        style = "fg:fgdim";
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
        format = "([$all_status$ahead_behind]($style) )";
      };

      # IMPORTANT: avoid Nix interpolation of ${added}/${deleted}
      git_metrics = {
        disabled = false;
        style = "fg:fgdim";
        # Build the literal string "${added}" and "${deleted}" via concatenation
        format = "([+" + "$" + "{added} ~" + "$" + "{deleted}" + "]($style) )";
      };

      # ---------- Nix / direnv ----------
      nix_shell = {
        symbol = " ";
        style = "fg:cyan";
        format = "[$symbol$state]($style) ";
      };
      direnv = {
        disabled = false;
        symbol = "↯ ";
        style = "fg:yellow";
        format = "[$symbol]($style) ";
      };

      # ---------- Languages / tools ----------
      package = {
        disabled = false;
        symbol = "󰏗 ";
        display_private = true;
        style = "fg:fgdim";
        format = "[$symbol$version]($style) ";
      };
      docker_context = {
        symbol = " ";
        style = "fg:cyan";
        format = "[$symbol$context]($style) ";
      };
      kubernetes = {
        disabled = false;
        symbol = "⎈ ";
        style = "fg:cyan";
        format = "[$symbol$context(::$namespace)]($style) ";
        detect_files = [
          "k8s"
          "kubernetes"
        ];
      };
      nodejs = {
        symbol = " ";
        style = "fg:green";
        scan_timeout = 30;
        format = "[$symbol$version]($style) ";
      };
      python = {
        symbol = " ";
        style = "fg:yellow";
        pyenv_version_name = true;
        format = "[$symbol$version]($style) ";
      };
      rust = {
        symbol = " ";
        style = "fg:red";
        format = "[$symbol$version]($style) ";
      };
      golang = {
        symbol = " ";
        style = "fg:cyan";
        format = "[$symbol$version]($style) ";
      };

      # ---------- System ----------
      memory_usage = {
        disabled = false;
        threshold = 70;
        symbol = " ";
        style = "fg:fgdim";
        format = "[$symbol$ram_pct%]($style) ";
      };
      jobs = {
        symbol = " ";
        style = "fg:fgdim";
        format = "[$symbol$number]($style) ";
      };
      status = {
        disabled = false;
        symbol = "⛔ ";
        map_symbol = true;
        style = "fg:red";
        format = "[$symbol$status]($style) ";
      };
      cmd_duration = {
        min_time = 500;
        show_milliseconds = false;
        style = "fg:fgdim";
        format = "[ $duration]($style) ";
      };
      time = {
        disabled = false;
        time_format = "%H:%M";
        style = "fg:fgdim";
        format = "[$time]($style)";
      };
    };
  };
}
