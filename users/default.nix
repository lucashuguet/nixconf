{ username, ... }:
{
  imports = [ ./${username}.nix ];

  users.mutableUsers = false;
}
