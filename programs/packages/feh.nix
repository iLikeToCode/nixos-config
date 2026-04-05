{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "feh-wrapper";

  src = pkgs.feh;

  dontUnpack = true;

  buildInputs = [ pkgs.makeWrapper ];

  buildPhase = ''
    cp -r $src $out
    chmod -R u+w $out
    cp $src/bin/feh $out/bin/feh-real
  '';

  installPhase = ''
    wrapProgram $out/bin/feh --add-flags "--info 'echo %wx%h'"
  '';
}