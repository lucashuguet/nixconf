# Lenovo IdeaPad Gaming 3 15HU6

{
  imports = [ ./hardware-configuration.nix ];

  system.stateVersion = "24.05";

  # fix time with windows dual boot
  time.hardwareClockInLocalTime = true;
}
