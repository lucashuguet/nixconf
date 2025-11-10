{ pkgs, config, username, ... }:
{
  sops.secrets."users/astrogoat/password".neededForUsers = true;

  users.users.${username} = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.sops.secrets."users/astrogoat/password".path;
  };
}
