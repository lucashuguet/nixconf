{apps, ...}:
{
  imports = (builtins.map (app: ./${app}.nix) apps) ++ [
    ./browsers
    ./gimp.nix
    ./libreoffice.nix
    ./mpv
    ./thunar.nix
    ./zathura.nix
  ];
}
