{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "bpytop";
  src = pkgs.fetchFromGitHub {
    owner = "aristocratos";
    repo = "bpytop";
    rev = "ac0f6660be0ad87b23ecb7f371a4a737e1bf017f";
    sha256 = "1dsl8zx2ds7qagbr6l41rsz5acrfxzqnnvms87x9rm4dxz3mw703";
  };

  buildInputs = with pkgs; [
    (python3.withPackages (ps: with ps; [psutil]))
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp ./bpytop.py $out/bin/bpytop

    mkdir -p $out/share/bpytop/doc
    cp ./README.md $out/share/bpytop/doc

    cp -R ./themes/ $out/share/bpytop

    chmod 755 $out/bin/bpytop
  '';
}
