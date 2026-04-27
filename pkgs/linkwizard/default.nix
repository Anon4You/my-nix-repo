{ stdenvNoCC
, python3
, fetchFromGitHub
, makeWrapper
, lib
, gnused
}:

let
  pythonEnv = python3.withPackages (ps: with ps; [
    requests
    rich
    beautifulsoup4
    pyfiglet
  ]);
in
stdenvNoCC.mkDerivation {
  pname = "linkwizard";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Anon4You";
    repo = "LinkWizard";
    rev = "main";
    sha256 = "sha256-d4ie7OtYejj1fjse21n02Ugnf2xdQbn7nKnSt03FFD8=";
  };

  nativeBuildInputs = [ makeWrapper gnused ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/linkwizard
    cp -r $src/* $out/share/linkwizard/

    # Patch 1: comment out os.chdir
    sed -i 's/^    os\.chdir(.*)/    # os.chdir disabled for Nix/' $out/share/linkwizard/lw.py

    # Patch 2: change the default --template argument to absolute store path
    sed -i 's|default="template.html"|default="'$out/share/linkwizard/template.html'"|' $out/share/linkwizard/lw.py

    mkdir -p $out/bin
    cat > $out/bin/linkwizard <<EOF
#!${pythonEnv}/bin/python3
import sys
import runpy
sys.path.insert(0, "$out/share/linkwizard")
sys.argv[0] = "$out/share/linkwizard/lw.py"
runpy.run_path("$out/share/linkwizard/lw.py", run_name="__main__")
EOF

    chmod +x $out/bin/linkwizard

    runHook postInstall
  '';

  meta = with lib; {
    description = "A tool to fetch and analyze links from a profile page";
    homepage = "https://github.com/Anon4You/LinkWizard";
    license = licenses.mit;
    platforms = platforms.all;
  };
}
