{ pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    virtualenv
    (python3.withPackages (ps: with ps; [
      numpy matplotlib requests beautifulsoup4 python-lsp-server
    ]))
  ];
}
