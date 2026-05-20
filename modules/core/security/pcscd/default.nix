{
  flake.nixosModules.pcscd = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ pcsc-tools ];
    services.pcscd.enable = true;
  };
}
