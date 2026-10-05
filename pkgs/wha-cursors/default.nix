{ pkgs, ... }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "ver-pinceau-cursors";
  version = "1.0";
  src = ./VerPinceau;

  dontBuild = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons/VerPinceau
    cp -a . $out/share/icons/VerPinceau/
    runHook postInstall
  '';
}
