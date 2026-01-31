# Lenovo Thinkpad T480

{ nixos-hardware, username, ... }:
{
  imports = [
    ./hardware-configuration.nix ./disko-config.nix
    ../../modules/hardware/nvidia
    nixos-hardware.nixosModules.lenovo-thinkpad-t480
  ];

  system.stateVersion = "25.11";

  boot.loader.efi.canTouchEfiVariables = true;

  sops.secrets = {
    "hosts/t480/komga_api".owner = username;
    "hosts/t480/private_key" = {
      path = "/home/${username}/.ssh/id_ed25519";
      owner = username;
      mode = "600";
    };
    "hosts/t480/public_key" = {
      path = "/home/${username}/.ssh/id_ed25519.pub";
      owner = username;
      mode = "644";
    };
  };
}
