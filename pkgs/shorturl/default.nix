{ stdenvNoCC, fetchurl, figlet, toilet, curl, makeWrapper, lib }:

let
  pname = "shorturl";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  version = "1.0.0";
  src = fetchurl {
    url = "https://github.com/Anon4You/shorturl/raw/main/shorturl.sh";
    hash = "sha256-trOZJnxrXC54xnyBc6Om8uBtDmMr1NQxoxpQ+bXuPBg=";
  };
  nativeBuildInputs = [ makeWrapper ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    wrapProgram $out/bin/${pname} --prefix PATH : ${lib.makeBinPath [toilet figlet curl]}
  '';
}
