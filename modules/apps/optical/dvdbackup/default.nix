{
  flake.nixosModules.dvdbackup = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      dvdbackup
    ];
  };
}
