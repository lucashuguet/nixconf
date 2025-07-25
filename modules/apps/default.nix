{apps, ...}:
{
  imports = (builtins.map (app: ./${app}.nix) apps) ++ [
    ./browsers
    ./emacs
    ./gimp.nix
    ./libreoffice.nix
    ./mpv
    ./thunar.nix
    ./zathura.nix
  ];
}
