{
  boot.kernelParams = [ "quiet" ];
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    configurationLimit = 10;
  };
}
