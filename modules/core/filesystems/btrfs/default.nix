{
  flake.nixosModules.btrfs = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ btrfs-snap ];
    boot.supportedFilesystems = [ "btrfs" ];
  };
}
