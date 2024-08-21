{ extra-browsers, ... }:
{
  imports = (builtins.map (br: ./${br}) extra-browsers) ++ [
    ./librewolf
  ];
}
