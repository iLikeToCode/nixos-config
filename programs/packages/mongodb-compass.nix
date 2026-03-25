{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  name = "mongodb-compass-wrapper";

  src = pkgs.mongodb-compass;

  dontUnpack = true;

  buildInputs = [ pkgs.makeWrapper ];

  buildPhase = ''
    cp -r $src $out
    chmod -R u+w $out
  '';

  installPhase = ''
    wrapProgram $out/bin/mongodb-compass --add-flags "--password-store="gnome-libsecret" --ignore-additional-command-line-flags"
  '';
}