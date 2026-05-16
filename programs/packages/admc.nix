{ pkgs, lib, ... }:
pkgs.stdenv.mkDerivation {
  name = "admc";

  src = pkgs.fetchFromGitHub {
    owner = "altlinux";
    repo = "admc";
    rev = "0.23.2-alt1";
    hash = "sha256-Z789YIgi94qe9+iezBF4N8Mx2xEWadwZETS/R8SsgHo=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    qt6.wrapQtAppsHook
    pkg-config
  ];

  buildInputs = with pkgs; [
    SDL2
    qt6.qtbase
    qt6.qttools
    openldap
    samba.dev
    talloc
    tdb
    tevent
    krb5
    cyrus_sasl.dev
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  postPatch = ''
    substituteInPlace src/admc/main.cpp \
      --replace-fail 'qWarning(e.what());' 'qWarning("%s", e.what());'
  '';
}