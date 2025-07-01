{ pkgs, username, ... }:
{
  services.xserver.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = false;
  services.gnome.rygel.enable = false;
  services.usbmuxd.enable = true;

  environment.systemPackages = with pkgs; [
    ifuse libimobiledevice
  ];

  home-manager.users.${username} = {
    dconf.settings = {
      "org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Alt>f";
        command = "librewolf";
        name = "librewolf";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>m";
        command = "alacritty -e ncmpcpp";
        name = "ncmpcpp";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        binding = "<Super>Return";
        command = "alacritty";
        name = "alacritty";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
        binding = "<Super>e";
        command = "thunar";
        name = "thunar";
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom4" = {
        binding = "<Alt>e";
        command = "emacsclient -c";
        name = "emacs";
      };

      "org/gnome/shell" = {
        favorite-apps = [
          "org.prismlauncher.PrismLauncher.desktop"
          "librewolf.desktop"
          "Alacritty.desktop"
          "pcmanfm.desktop"
        ];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [];
        switch-to-application-2 = [];
        switch-to-application-3 = [];
        switch-to-application-4 = [];
        toggle-message-tray = [];
      };
    };
  };
}
