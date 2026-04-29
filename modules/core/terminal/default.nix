{ self, ... }: {
  flake.nixosModules.terminal = { pkgs, ... }: {
    imports = with self.nixosModules; [
      alacritty
      fastfetch
      fish
      fonts
      neovim
      starship
    ];

    environment.systemPackages = with pkgs; [ zoxide ueberzugpp ];
  };
}
