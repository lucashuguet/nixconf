{ self, ... }: {
  flake.nixosModules.audio = { username, ... }: {
    imports = with self.nixosModules; [
      alsa
      pavucontrol
      pipewire
    ];

    users.users.${username} = {
      extraGroups = [ "audio" ];
    };
  };
}
