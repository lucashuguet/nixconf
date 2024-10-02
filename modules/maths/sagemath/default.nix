{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [ sage ];
}
