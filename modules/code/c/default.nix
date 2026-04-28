{
  flake.nixosModules.cLang = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      clang clang-tools
    ];
  };
}
