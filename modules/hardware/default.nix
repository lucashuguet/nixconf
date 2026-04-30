{ self, ... }: {
  flake.nixosModules.hardware = { lib, nvidia, ... }: {
    imports = with self.nixosModules; [
      audio
      bluetooth
      network
      steelseries
    ] ++ lib.optional nvidia self.nixosModules.nvidia;
  };
}
