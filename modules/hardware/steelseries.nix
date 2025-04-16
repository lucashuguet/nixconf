{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ rivalcfg ];
}
