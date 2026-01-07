{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pinentry-rofi
    (pass.withExtensions (ext: with ext; [pass-otp]))
  ];
}
