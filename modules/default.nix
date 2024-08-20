{ DE, ... }:
{
  imports = (builtins.map (de: ./${de}) DE) ++ [
    ./apps
    ./core
    ./hardware
    ./music
    ./sddm
  ];
}
