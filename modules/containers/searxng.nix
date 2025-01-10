{ pkgs, ... }:
{
  containers.searxng = {
    autoStart = true;
    ephemeral = true;
    config = {
      system.stateVersion = "24.11";

      services.searx = {
        enable = true;
        package = pkgs.searxng;
        redisCreateLocally = true;
        settings = {
          server = {
            port = 8888;
            bind_address = "127.0.0.1";
            image_proxy = true;
            secret_key = "secret";
            limiter = true;
          };

          ui = {
            autofocus = true;
            default_theme = "simple";
            theme_args.simple_style = "black";
            default_locale = "en";
            results_on_new_tab = false;
            hotkeys = "vim";
          };

          outgoing.request_timeout = 3;

          search = {
            safe_search = 1;
            autocomplete = "";
            languages = [ "all" "en" "en-US" "fr" ];
            formats = ["html" "csv" "json"];
          };
        };

        limiterSettings = {
          botdetection.ip_limit.link_token = true;
        };
      };
    };
  };
}
