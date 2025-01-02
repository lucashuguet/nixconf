{ DE, ... }:
{
  imports = (builtins.map (de: ./${de}) DE);
}
