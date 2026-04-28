{
  flake.nixosModules.mpd = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ mpc ncmpcpp cava ];

    home-manager.users.${username} = {
      services.mpd = {
        enable = true;

        musicDirectory = "/home/${username}/Music";

        playlistDirectory = "/home/${username}/.mpd/playlists";
        dbFile = "/home/${username}/.mpd/database";
        dataDir = "/home/${username}/.mpd/";

        network.listenAddress = "127.0.0.1";
        network.port = 6600;

        extraConfig = ''
          audio_output {
          type "pipewire"
          name "My PipeWire Output"
        }

        replaygain "track"
        '';
      };
    };
  };
}
