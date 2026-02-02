{ pkgs, ... }:
let
  impactor = ( import ./impactor.nix ) { inherit pkgs; };
in {
  environment.systemPackages = [ impactor ];
}
