{ stdenvNoCC, fetchurl, makeWrapper, lib }:

stdenvNoCC.mkDerivation {
  pname = "fuckyou";
  version = "1.0.1";
  src = fetchurl {
    url = "https://raw.githubusercontent.com/Anon4You/FuckYou/refs/heads/main/fuckyou.sh";
    hash = "sha256-KPGQ5XQX//U3JpnNyz/7MgXfG3ORe0MiJi3hLnYm0U8=";
  };
  nativeBuildInputs = [ makeWrapper ];
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/fuckyou
    chmod +x $out/bin/fuckyou
    wrapProgram $out/bin/fuckyou --prefix PATH : ${lib.makeBinPath []}
  '';
}
