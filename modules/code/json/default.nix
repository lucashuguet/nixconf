{
  flake.nixosModules.jsonLang = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ jq ];
  };
}
