{
  flake.nixosModules.fish = { pkgs, username, ... }: {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        abbr -a !! --position anywhere (echo $history[1])

        if test -e /run/secrets/hosts/(hostname)/komga_api;
          set -x KOMGA_API (cat /run/secrets/hosts/(hostname)/komga_api)
        end

        set -g fish_transient_prompt 1
        set fish_greeting

        zoxide init fish | source

        if test -n "$DISPLAY";
          if test (id -u) -ne 0
            fastfetch
          end

          function starship_transient_prompt_func
            starship module character
          end

          starship init fish | source
          enable_transience
        end
      '';
      promptInit = ''
        function fish_prompt
          set -l last_status $status
          set -l stat
          if test $last_status -ne 0
            set stat (set_color -o red)"[$last_status]"(set_color -o normal)
          end

          if contains -- --final-rendering $argv
            echo (set_color -o red)"\$" (set_color normal)
          else
            echo (set_color -o red)$USER(set_color -o normal)"@"(set_color -o red)$hostname (set_color -o normal)"in" (set_color -o purple)(prompt_pwd) $stat "\$" (set_color normal)
          end
        end
      '';
      shellAliases = {
        ls = "${pkgs.eza}/bin/eza -al --color=always --group-directories-first --icons";
        la = "${pkgs.eza}/bin/eza -a --color=always --group-directories-first --icons";
        ll = "${pkgs.eza}/bin/eza -l --color=always --group-directories-first --icons";
        lt = "${pkgs.eza}/bin/eza -aT --color=always --group-directories-first --icons";
        "l." = "${pkgs.eza}/bin/eza -a | egrep '^\.'";
        ip = "ip -color";

        cat = "${pkgs.bat}/bin/bat --style header --style rule --style snip --style changes --style header";

        vim = "nvim";
        dev = "nix develop --command fish";

        gmpv = "nvidia-offload mpv -vo gpu";

        em = "emacsclient -nc";
        e = "emacsclient -nw -c";
      };
      shellAbbrs = {
        at = "aria2c -j8 -x16 -s16 --seed-time=0";
        atl = "aria2c -j8 -x16 -s16 --seed-time=0 --show-files";
        ats = "aria2c -j8 -x16 -s16 --seed-time=0 --select-file=";
        ad = "aria2c -j8 -x16 -s16 -c";
        ai = "aria2c -j8 -x16 -s16 -c --input-file=";
      };
    };
    programs.command-not-found.enable = false;

    users.users.root.shell = pkgs.fish;

    home-manager.users.${username} = {
      programs.fish.enable = true;
      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
      };
      home.sessionPath = [
        "$HOME/.local/bin"
      ];
    };
  };
}
