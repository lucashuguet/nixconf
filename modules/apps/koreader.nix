{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ koreader ];
}
