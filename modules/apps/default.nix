{apps, ...}:
{
  imports = (builtins.map (app: ./${app}.nix) apps) ++ [
    ./browsers
    ./emacs.nix
    ./gimp.nix
    ./libreoffice.nix
    ./mpv
    ./zathura.nix
  ];
}
