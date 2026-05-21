{
  flake.nixosModules.pipewire = { ... }: {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."combined-sink" = {
        "context.objects" = [
          {
            factory = "adapter";
            args = {
              "factory.name"     = "support.null-audio-sink";
              "node.name"        = "combined-sink";
              "node.description" = "Combined Sink";
              "media.class"      = "Audio/Sink";
              "audio.position"   = "FL,FR";
            };
          }
        ];
      };
    };
  };
}
