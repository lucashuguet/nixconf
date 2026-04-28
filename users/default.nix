{
  flake.nixosModules.users = { ... }: {
    users.mutableUsers = false;
    users.allowNoPasswordLogin = true;
  };
}
