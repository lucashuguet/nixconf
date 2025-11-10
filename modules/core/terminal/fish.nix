{ pkgs, username, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      abbr -a !! --position anywhere (echo $history[1])

      if test -e /run/secrets/hosts/(hostname)/komga_api;
        set -x KOMGA_API (cat /run/secrets/hosts/(hostname)/komga_api)
      end

      set fish_greeting

      zoxide init fish | source
      fastfetch
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
      atd = "aria2c --seed-time=0 --max-upload-limit=1";
      ats = "aria2c --seed-time=0 --max-upload-limit=1 --show-files";
      atds = "aria2c --seed-time=0 --max-upload-limit=1 --select-file=";
      add = "aria2c --continue=true";
    };
  };
  programs.command-not-found.enable = false;

  home-manager.users.${username} = {
    programs.fish.enable = true;
    home.sessionPath = [
      "$HOME/.local/bin"
    ];
  };
}
