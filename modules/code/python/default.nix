{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    virtualenv
    (python3.withPackages (ps: with ps; [numpy requests beautifulsoup4 python-lsp-server]))
  ];
}
