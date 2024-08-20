{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    virtualenv
    (python3.withPackages (ps: with ps; [numpy python-lsp-server]))
  ];
}
