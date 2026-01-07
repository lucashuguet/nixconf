{ lib, ... }:
{
  imports = lib.filesystem.listFilesRecursive ./devices;
}
