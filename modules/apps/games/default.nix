{ pkgs, username, ... }:
{
  imports = [ ./lutris ];

  environment.systemPackages = with pkgs; [ gamemode ];

  hardware.xone.enable = true;
  users.users.${username} = {
    extraGroups = [ "input" ];
  };
}
