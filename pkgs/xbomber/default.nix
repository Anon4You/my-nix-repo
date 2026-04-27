{ stdenvNoCC, python3, fetchFromGitHub, makeWrapper, lib }:

let
  pythonEnv = python3.withPackages (ps: with ps; [
    requests
    rich
  ]);
in
stdenvNoCC.mkDerivation {
  pname = "xbomber";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "Anon4You";
    repo = "XBomber";
    rev = "2.0.0";
    sha256 = "sha256-D90oBWTHrvduy+L9iIKjqS9A8Ng/4Hi/z7FF0BwZwFQ=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/xbomber
    cp -r $src/* $out/share/xbomber/

    mkdir -p $out/bin
    cat > $out/bin/xbomber <<EOF
    #!${pythonEnv}/bin/python3
    import os
    import sys
    os.chdir("$out/share/xbomber")
    with open("xbomber.py") as f:
        exec(f.read())
    EOF

    chmod +x $out/bin/xbomber

    runHook postInstall
  '';
}
