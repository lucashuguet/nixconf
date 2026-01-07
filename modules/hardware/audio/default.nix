{ username, ... }:
{
  imports = [
    ./alsa
    ./pavucontrol
    ./pipewire
  ];

  users.users.${username} = {
    extraGroups = [ "audio" ];
  };
}
