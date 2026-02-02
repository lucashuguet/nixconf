{ pkgs, ... }:
let
  iloader = ( import ./iloader.nix ) { inherit pkgs; };
in {
  environment.systemPackages = [ iloader ];
}
