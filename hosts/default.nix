{ hostname, ... }:
{
  imports = [ ./${hostname} ];
}
