{ self, ... }: {
  flake.nixosModules.users = { username, ... }: {
    imports = [ self.nixosModules.${"${username}User"} ];

    users.mutableUsers = false;
    users.allowNoPasswordLogin = true;
  };
}
