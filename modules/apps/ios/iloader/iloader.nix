{ pkgs, ... }:

pkgs.appimageTools.wrapType2 rec {
  pname = "iloader";
  version = "1.1.6";

  src = pkgs.fetchurl {
    url = "https://github.com/nab138/iloader/releases/download/v${version}/iloader-linux-amd64.AppImage";
    hash = "sha256-L1fFwFjdIrrhviBlwORhSDXsNYgrT1NcVKAKlss6h4o=";
  };

  extraInstallCommands =
    let
      contents = pkgs.appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      cp -r ${contents}/usr/share/icons $out/share
    '';
}
