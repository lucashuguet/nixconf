{ self, ... }: {
  flake.nixosModules.optical = { pkgs, username, ... }: {
    imports = with self.nixosModules; [ brasero ];

    users.users.${username}.extraGroups = [ "cdrom" ];
    environment.systemPackages = with pkgs; [ dvdbackup handbrake ];
  };
}
