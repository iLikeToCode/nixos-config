{
  pkgs,
  lib ? pkgs.lib,
  fetchFromGitHub ? pkgs.fetchFromGitHub,
  cmake ? pkgs.cmake,
  ninja ? pkgs.ninja,
  pkg-config ? pkgs.pkg-config,

  udev ? pkgs.udev,
  alsa-lib ? pkgs.alsa-lib,
  ola ? pkgs.ola,
  libftdi1 ? pkgs.libftdi1,
  libusb-compat-0_1 ? pkgs.libusb-compat-0_1,
  libsndfile ? pkgs.libsndfile,
  libmad ? pkgs.libmad,

  qtbase ? pkgs.libsForQt5.qt5.qtbase,
  qtmultimedia ? pkgs.libsForQt5.qt5.qtmultimedia,
  qtscript ? pkgs.libsForQt5.qt5.qtscript,
  qtserialport ? pkgs.libsForQt5.qt5.qtserialport,
  qttools ? pkgs.libsForQt5.qt5.qttools,
  qtwebsockets ? pkgs.libsForQt5.qt5.qtwebsockets,
  wrapQtAppsHook ? pkgs.libsForQt5.wrapQtAppsHook,
  ...
}:

pkgs.stdenv.mkDerivation rec {
    pname = "qlcplus";
    version = "5.2.1";

    src = fetchFromGitHub {
      owner = "mcallegari";
      repo = "qlcplus";
      rev = "QLC+_${version}";
      sha256 = "sha256-kERLpQPzUQHJvQPWlQc1l1VnDSZlrVxermbx+DOn8Co=";
    };

    nativeBuildInputs = [
      cmake
      ninja
      pkg-config
      wrapQtAppsHook
    ];

    buildInputs = [
      qtbase
      qtmultimedia
      qtscript
      qtserialport
      qttools
      qtwebsockets

      udev
      alsa-lib
      ola
      libftdi1
      libusb-compat-0_1
      libsndfile
      libmad
    ];

    postPatch = ''
      patchShebangs .

      # Don't hardcode /usr
      substituteInPlace variables.cmake \
        --replace-fail 'set(INSTALLROOT "/usr")' 'set(INSTALLROOT "")' \
        --replace-fail 'set(UDEVRULESDIR "/etc/udev/rules.d")' 'set(UDEVRULESDIR "lib/udev/rules.d")'
    '';

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
    ];

    meta = with lib; {
      description = "Free and cross-platform DMX lighting control software";
      homepage = "https://www.qlcplus.org/";
      license = licenses.asl20;
      platforms = platforms.linux;
    };
}