{ self, ... }: {
  flake.nixosModules.games = { pkgs, username, ... }: {
    imports = with self.nixosModules; [
      lutris
      prismlauncher
      retroarch
      steam
    ];

    environment.systemPackages = with pkgs; [ gamemode ];

    hardware.xone.enable = true;

    users.users.${username} = {
      extraGroups = [ "input" ];
    };
  };
}
