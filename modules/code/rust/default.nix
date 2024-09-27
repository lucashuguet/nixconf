{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo cargo-nextest rustup rust-analyzer
  ];
}
