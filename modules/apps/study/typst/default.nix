{
  flake.nixosModules.typst = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ tinymist typst ];
  };
}
