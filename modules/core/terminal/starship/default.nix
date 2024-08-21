{
  programs.starship = {
    enable = true;
    settings = {
      username = {
        format = " [$user]($style)@";
        show_always = true;
        style_user = "red bold";
        style_root = "red bold";
      };

      hostname = {
        format = "[$hostname]($style) in ";
        style = "bold dimmed red";
        ssh_only = false;
        disabled = false;
      };

      directory = {
        style = "purple";
        truncate_to_repo = true;
        truncation_length = 0;
        truncation_symbol = "repo: ";
      };

      character = {
        success_symbol = " [λ](bold red)";
        error_symbol = " [×](bold red)";
      };

      sudo = {
        symbol = "sudo: ";
      };

      git_commit = {
        tag_symbol = " tag ";
      };
      
      git_status = {
        ahead = ">";
        behind = "<";
        diverged = "<>";
        renamed = "r";
        deleted = "x";

        style = "white";
      };

      cmd_duration = {
        format = "took [$duration]($style)";
        min_time = 1;
      };

      aws = {
        symbol = " ";
      };

      conda = {
        symbol = " ";
      };

      dart = {
        symbol = " ";
      };

      docker_context = {
        symbol = " ";
      };

      elixir = {
        symbol = " ";
      };

      elm = {
        symbol = " ";
      };

      git_branch = {
        symbol = " ";
      };

      golang = {
        symbol = " ";
      };

      hg_branch = {
        symbol = " ";
      };

      java = {
        symbol = " ";
      };

      julia = {
        symbol = " ";
      };

      nim = {
        symbol = " ";
      };

      nix_shell = {
        symbol = "󱄅 ";
      };

      nodejs = {
        symbol = " ";
      };

      package = {
        symbol = " ";
      };

      perl = {
        symbol = " ";
      };

      php = {
        symbol = " ";
      };

      python = {
        symbol = " ";
      };

      ruby = {
        symbol = " ";
      };

      rust = {
        symbol = " ";
      };

      swift = {
        symbol = " ";
      };
    };
  };
}
