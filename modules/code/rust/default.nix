{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (rust-bin.stable.latest.default.override {
      extensions = [ "clippy" "rustfmt" "rust-src" "rust-analyzer"];
      targets = [ "wasm32-unknown-unknown" "x86_64-unknown-linux-gnu" ];
    }) cargo
  ];
}
