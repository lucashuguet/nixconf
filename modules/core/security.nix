{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pinentry pinentry-rofi
    (pass.withExtensions (ext: with ext; [pass-otp]))
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-rofi;
    enableSSHSupport = true;
  };

  services.pcscd.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 21 80 4002 ];
  };
}
