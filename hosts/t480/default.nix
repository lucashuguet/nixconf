# Lenovo Thinkpad T480

{
  nixos-06cb-009a-fingerprint-sensor,
  nixos-hardware,
  username,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix ./disko-config.nix
    ../../modules/hardware/nvidia
    nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
    nixos-hardware.nixosModules.lenovo-thinkpad-t480
  ];

  system.stateVersion = "25.11";

  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModprobeConfig = ''
    options psmouse synaptics_intertouch=1
  '';

  environment.systemPackages = with pkgs; [ pcsc-tools ];
  services.pcscd.enable = true;

  services."06cb-009a-fingerprint-sensor" = {
    enable = true;
    backend = "python-validity";
  };

  security.pam.services = lib.genAttrs
    [ "greetd" ]
    (name: { fprintAuth = lib.mkDefault true; });

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
