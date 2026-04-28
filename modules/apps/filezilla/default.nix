{
  flake.nixosModules.filezilla = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ filezilla ];
  };
}
