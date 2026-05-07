{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  pname = "piper-tts-py";
  version = "1.0";

  src = pkgs.piper-tts;

  installPhase = ''
    cp -r $src/lib/python3.13 $out/lib/python3.13
  '';
}