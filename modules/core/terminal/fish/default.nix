{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
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
    };
  };
}
