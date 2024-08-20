{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      (callPackage ./bpytop.nix {})
    ];
  };
}
