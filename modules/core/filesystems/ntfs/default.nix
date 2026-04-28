{
  flake.nixosModules.ntfs = {
    boot.supportedFilesystems = [ "ntfs" ];
  };
}
