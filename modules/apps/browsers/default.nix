{ extraBrowsers, ... }:
{
  imports = (builtins.map (br: ./${br}) extraBrowsers) ++ [
    ./librewolf
  ];
}
