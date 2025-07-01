{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ xfce.thunar ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
