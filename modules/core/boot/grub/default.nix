{
  boot.kernelParams = [ "quiet" ];
  boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    configurationLimit = 10;
  };
}
