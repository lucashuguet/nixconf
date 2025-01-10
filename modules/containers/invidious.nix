{ pkgs, config, ... }:
{
  containers.invidious = {
    ephemeral = true;
    config = {
      system.stateVersion = "24.11";

      services.invidious = {
        enable = true;
        package = pkgs.invidious;
        sig-helper.enable = true;
        settings = {
          popular_enabled = false;
          captcha_enabled = false;
          registration_enabled = false;

          default_user_preferences = {
            locale = "en-US";
            region = "US";
            captions = ["English" "French" ""];
            dark_mode = "dark";
            feed_menu = ["Subscriptions" "Playlists"];
            default_home = "Subscriptions";
          };
        };
        extraSettingsFile = config.sops.secrets.invidious.path;
      };
    };
    bindMounts.${config.sops.secrets.invidious.path}.isReadOnly = true;
  };
}
