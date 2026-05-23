{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "admc";
  version = "0.23.2-alt1";

  src = pkgs.fetchFromGitHub {
    owner = "altlinux";
    repo = "admc";
    rev = version;
    hash = "sha256-Z789YIgi94qe9+iezBF4N8Mx2xEWadwZETS/R8SsgHo=";
  };

  nativeBuildInputs = with pkgs; [
    cmake
    ninja
    pkg-config
    qt6.wrapQtAppsHook
    copyDesktopItems
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

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "admc";
      desktopName = "ADMC";
      comment = "Active Directory Management Center";
      exec = "admc";
      icon = "admc";
      terminal = false;
      categories = [ "System" "Network" ];
    })
  ];

  meta = with lib; {
    description = "ADMC from ALT Linux";
    homepage = "https://github.com/altlinux/admc";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}