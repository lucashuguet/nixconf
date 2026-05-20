{ self, ... }: {
  flake.nixosModules.hardware = { lib, pkgs, nvidia, ... }: {
    imports = with self.nixosModules; [
      audio
      bluetooth
      network
      steelseries
    ] ++ lib.optional nvidia self.nixosModules.nvidia;

    environment.systemPackages = with pkgs; [ fwupd ];
    services.fwupd.enable = true;
  };
}
