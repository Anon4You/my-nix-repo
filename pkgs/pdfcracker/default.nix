{ stdenvNoCC, fetchurl, qpdf, makeWrapper, lib }:

let
  pname = "pdfcracker";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/Anon4You/PDFCracker/raw/main/pdfcracker.sh";
    hash = "sha256-SevR8qMAL7I+YsVhAGrZwkAeT7/u7GzpPWhfRN3FR5s=";
  };
  nativeBuildInputs = [ makeWrapper ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    wrapProgram $out/bin/${pname} --prefix PATH : ${lib.makeBinPath [qpdf]}
  '';
}
