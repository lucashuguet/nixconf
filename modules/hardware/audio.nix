{ pkgs, username, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  users.users.${username} = {
    extraGroups = [ "audio" ];
  };

  environment.systemPackages = with pkgs; [ pavucontrol alsa-utils ];
}
