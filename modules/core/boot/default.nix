# { self, ... }:
{
  flake.nixosModules.boot = { ... }: {
    # imports = with self.nixosModules; [
    #   grub
    # ];

    boot.plymouth.enable = true;

    boot.kernelParams = [
      "quiet" "splash" "loglevel=3"
      "rd.systemd.show_status=false" "rd.udev.log_level=3" "udev.log_priority=3"
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 5;
    boot.loader.efi.canTouchEfiVariables = true;

    boot.initrd.systemd.enable = true;
    boot.initrd.kernelModules = [ "i915" ];
    boot.initrd.compressor = "zstd";
    boot.initrd.compressorArgs = [ "-19" "-T0"];
  };
}
