{ hostname, ... }:
{
  imports = [ ./${hostname} ./locale ];
}