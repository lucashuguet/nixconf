{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ mpc-cli ncmpcpp ];
  };

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
    '';
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };
}
