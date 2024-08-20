{ pkgs, config, username, ... }:
{
  boot = {
    initrd.kernelModules = [ "nvidia" ];
    extraModprobeConfig = ''
      blacklist nouveau
      options nvidia-drm modeset=1
    '';
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [vaapiVdpau];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
	      enable = true;
        enableOffloadCmd =  true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  users.users.${username} = {
    extraGroups = [ "video" "render" ];
  };
}
