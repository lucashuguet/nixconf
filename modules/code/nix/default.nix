{
  flake.nixosModules.nixLang = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ nixd nixfmt-rfc-style ];
  };
}
