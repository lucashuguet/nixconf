# Lenovo Thinkpad T470

{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ./disko-config.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
}
