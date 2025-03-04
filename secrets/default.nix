{ pkgs, username, ... }:
{
 environment.systemPackages = with pkgs; [ sops ]; 

  sops = {
    defaultSopsFile = ./secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
    secrets.komga_api = {
      owner = username;
    };
  };
}
