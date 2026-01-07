{ windowManager, ... }:
{
  imports = (builtins.map (wm: ./${wm}) windowManager);
}
