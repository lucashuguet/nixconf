{
  imports = [ ./hardware-configuration.nix ];

  # fix time with windows dual boot
  time.hardwareClockInLocalTime = true;
}
