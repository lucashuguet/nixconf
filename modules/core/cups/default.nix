{ lib, ... }:
{
  imports = lib.filesystem.listFilesRecursive ./printers;

  services.printing.enable = true;
}
