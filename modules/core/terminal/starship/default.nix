{
  programs.starship = {
    enable = true;
    settings = {
      username = {
        format = " [$user]($style)@";
        show_always = true;
        style_user = "green bold";
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
        symbol = "\uebaa ";
      };

      conda = {
        symbol = "\uec16 ";
      };

      dart = {
        symbol = "\ue798 ";
      };

      docker_context = {
        symbol = "\uf21f ";
      };

      elixir = {
        symbol = "\ue62d ";
      };

      elm = {
        symbol = "\ue62c ";
      };

      git_branch = {
        symbol = "\ue725 ";
      };

      golang = {
        symbol = "\ue627 ";
      };

      hg_branch = {
        symbol = "\ue725 ";
      };

      java = {
        symbol = "\ue738 ";
      };

      julia = {
        symbol = "\ue624 ";
      };

      nim = {
        symbol = "\ue677 ";
      };

      nix_shell = {
        symbol = "\uf313 ";
      };

      nodejs = {
        symbol = "\ued0d ";
      };

      package = {
        symbol = "\ueb29 ";
      };

      perl = {
        symbol = "\ue67e ";
      };

      php = {
        symbol = "\ue608 ";
      };

      python = {
        symbol = "\ue73c ";
      };

      ruby = {
        symbol = "\ue739 ";
      };

      rust = {
        symbol = "\ue7a8 ";
      };

      swift = {
        symbol = "\ue755 ";
      };
    };
  };
}
