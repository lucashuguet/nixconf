{ self, ... }: {
  flake.nixosModules.audio = { pkgs, username, ... }: {
    imports = with self.nixosModules; [
      alsa pipewire
    ];

    environment.systemPackages = with pkgs; [ pulsemixer ];

    users.users.${username} = {
      extraGroups = [ "audio" ];
    };
  };
}
