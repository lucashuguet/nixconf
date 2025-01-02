{ pkgs, username, ... }:
{
  users.users.${username} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}
