{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pinentry pinentry-gtk2
    (pass.withExtensions (ext: with ext; [pass-otp]))
  ];

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gtk2;
    enableSSHSupport = true;
  };

  services.pcscd.enable = true;
}
