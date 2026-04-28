{ self, ... }:
{
  flake.nixosModules.hardware = { ... }: {
    imports = with self.nixosModules; [
      audio
      bluetooth
      network
      steelseries
    ];
  };
}
