{ pkgs, username, ... }:
{
  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
  
  environment.systemPackages = with pkgs; [ docker-compose ];
  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
}
