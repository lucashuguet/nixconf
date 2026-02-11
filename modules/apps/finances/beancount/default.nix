{ pkgs, ... }:
{
  programs.python.extraPackages = ps: with ps; [
    beangulp camelot tabula-py
  ];

  environment.systemPackages = with pkgs; [
    beancount fava jdk21
  ];
}
