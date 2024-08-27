# Lenovo IdeaPad Gaming 3 15HU6

{
  imports = [ ./hardware-configuration.nix ];

  # fix time with windows dual boot
  time.hardwareClockInLocalTime = true;
}
