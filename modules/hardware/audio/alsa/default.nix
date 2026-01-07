{ pkgs, ... }:
{
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    alsa-utils
  ];
}
