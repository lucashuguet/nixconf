# Lenovo Thinkpad T470

{ username, ... }:
{
  imports = [ ./hardware-configuration.nix ./disko-config.nix ];

  system.stateVersion = "25.05";

  boot.loader.efi.canTouchEfiVariables = true;

  sops.secrets = {
    "hosts/t470/komga_api".owner = username;
    "hosts/t470/private_key" = {
      path = "/home/${username}/.ssh/id_ed25519";
      owner = username;
      mode = "600";
    };
    "hosts/t470/public_key" = {
      path = "/home/${username}/.ssh/id_ed25519.pub";
      owner = username;
      mode = "644";
    };
  };
}
