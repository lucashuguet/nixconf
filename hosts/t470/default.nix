# Lenovo Thinkpad T470

{
  imports = [ ./hardware-configuration.nix ./disko-config.nix ];

  boot.loader.efi.canTouchEfiVariables = true;
}
