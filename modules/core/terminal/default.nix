{ self, ... }: {
  flake.nixosModules.terminal = { ... }: {
    imports = with self.nixosModules; [
      alacritty
      fastfetch
      fish
      fonts
      neovim
      starship
      zoxide
    ];
  };
}
