{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    julia
  ];
}
