{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "dev.khcrysalis.PlumeImpactor";
  version = "2.0.3";

  src = pkgs.fetchurl {
    url = "https://github.com/khcrysalis/Impactor/releases/download/v${version}/Impactor-linux-x86_64.appimage";
    hash = "sha256-zT0XTTGJGffSDqdHZlybvtg9uybKF1iUQaVRyZvBwO4=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=plumeimpactor' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';
}
