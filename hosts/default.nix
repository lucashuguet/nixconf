{ hostname, ... }:
{
  imports = [ ./${hostname} ./locale ];
}
