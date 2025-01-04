{ st, system, ... }:
{
  environment.systemPackages = [ st.packages.${system}.default ];
}
