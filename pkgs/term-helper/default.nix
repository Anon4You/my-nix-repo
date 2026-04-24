with import <nixpkgs> {};
callPackage ({stdenvNoCC, fetchurl, curl, pv, makeWrapper, lib}:
  stdenvNoCC.mkDerivation{
    pname = "term-helper";
    version = "1.1.1";

    src = fetchurl {
      url = "https://github.com/Anon4You/term-helper/raw/main/term-helper.sh";
      hash = "sha256-O26VIxjxQay7US5artA5v/D+5Qs2wIRj0UcmU8wrZFU=";
    };

    nativeBuildInputs = [makeWrapper];
    dontUnpack = true;

    installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/$pname
    chmod +x $out/bin/$pname
    wrapProgram $out/bin/$pname --prefix PATH : ${lib.makeBinPath [pv curl]}
    '';
  }
){}
