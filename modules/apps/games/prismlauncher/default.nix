{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
    jdk8 jdk17 jdk21
  ];
}
