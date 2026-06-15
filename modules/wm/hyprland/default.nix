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
    hyprConfig = builtins.readFile ./hyprland.lua;
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
      brightnessctl
      hyprshot
      awww
      wl-clipboard
      wlr-randr
    ];

    users.users.${username}.extraGroups = [ "video" ];

    home-manager.users.${username} = {
      home.file = {
        ".config/hypr/hyprland.lua".text = ''
          hl.monitor({
            output = "",
            mode = "${resolution}",
            position = "0x0",
            scale = 1
          })
          ${extraHyprConfig}
          ${lib.optionalString nvidia ''
            hl.env("LIBVA_DRIVER_NAME", "nvidia")
            hl.env("GBM_BACKEND", "nvidia-drm")
            hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
          ''}

          ${hyprConfig}
        '';
      };
    };
  };
}
