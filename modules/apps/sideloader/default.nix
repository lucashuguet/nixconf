{ pkgs, ... }:
let
  sideloader = ( import ./sideloader.nix ) { inherit pkgs; };
in {
  environment.systemPackages = [ sideloader ];
}
