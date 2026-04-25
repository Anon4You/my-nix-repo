{ stdenvNoCC, fetchurl, zip, unzip, makeWrapper, lib }:

let
  pname = "zipcracker";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/Anon4You/ZipCracker/raw/main/zipcracker.sh";
    hash = "sha256-tctuoBJnJO+Tr0BXnilJXYokK+vT5ZJM0gEO8Vu514U=";
  };
  nativeBuildInputs = [ makeWrapper ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    wrapProgram $out/bin/${pname} --prefix PATH : ${lib.makeBinPath [zip unzip]}
  '';
}
