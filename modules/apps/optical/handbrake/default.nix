{
  flake.nixosModules.handbrake = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      handbrake
    ];
  };
}
