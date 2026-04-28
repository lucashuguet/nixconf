{ self, ... }: {
  flake.nixosModules.optical = { username, ... }: {
    imports = with self.nixosModules; [
      brasero
      dvdbackup
      handbrake
    ];

    users.users.${username}.extraGroups = [ "cdrom" ];
  };
}
