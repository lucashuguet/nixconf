{ self, ... }: {
  flake.nixosModules.hyprland = {
    lib,
    pkgs,
    username,
    resolution,
    nvidia,
    extraHyprConfig,
    ...
  }: let
    hyprConfig = builtins.readFile ./hyprland.conf;
  in{
    imports = with self.nixosModules; [
      bpytop
      dunst
      hyprlock
      rofi
      waybar
    ];

    programs.hyprland = {
      enable = true;
      withUWSM = false;
    };

    environment.systemPackages = with pkgs; [
      swww
      hyprshot
      wl-clipboard
      wlr-randr
    ];

    programs.light.enable = true;
    users.users.${username}.extraGroups = [ "video" ];

    home-manager.users.${username} = {
      home.file = {
        ".config/hypr/hyprland.conf".text = ''
          monitor = ,${resolution},0x0,1

          ${extraHyprConfig}

          ${lib.optionalString nvidia ''
            env = LIBVA_DRIVER_NAME,nvidia
            env = GBM_BACKEND,nvidia-drm
            env = __GLX_VENDOR_LIBRARY_NAME,nvidia
          ''}

          ${hyprConfig}
        '';
      };
    };
  };
}
