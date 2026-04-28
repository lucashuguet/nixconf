{ self, ... }: {
  flake.nixosModules.code = { ... }: {
    imports = with self.nixosModules; [
      cLang
      jsonLang
      nixLang
      nodeLang
      pythonLang
      rustLang
      sqliteLang
    ];
  };
}
