{
  description = "Webots Robot Simulator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    webots.url = "https://github.com/cyberbotics/webots/releases/download/R2025a/webots-R2025a-x86-64.tar.bz2";
    webots.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, webots }:
    flake-utils.lib.eachSystem [ flake-utils.lib.system.x86_64-linux ] (system:
      let
        pkgs = (import nixpkgs) { inherit system; };
        dependencies = with pkgs; [
          brotli
          sndio
          boost
          cmake
          curl
          dbus
          expat
          ffmpeg
          fox
          freetype
          gdal
          gl2ps
          glew
          glib
          gnumake
          gnupg
          jdk
          krb5
          libGL
          libGLU
          libgcrypt
          libssh2
          libuuid
          libxkbcommon
          libxml2
          libzip
          lsb-release
          nss_latest
          pbzip2
          pkg-config
          prelink
          proj
          python311
          readline
          swig
          unzip
          wget
          xercesc
          xorg.libX11
          xorg.libXcomposite
          xorg.libXtst
          xorg.libxcb
          xorg.xcbutil
          xvfb-run
          zip
          zlib
        ];
        desktopFile = (pkgs.makeDesktopItem {
          name = "webots-fhs";
          exec = "%%EXEC%%";
          icon = "${webots}/resources/icons/core/webots.png";
          comment = "Webots in an FHS environment";
          desktopName = "Webots (FHS)";
          genericName = "Webots (FHS)";
          categories = [ "Utility" ];
        });
      in
      rec {
        formatter = nixpkgs.legacyPackages.${system}.nixpkgs-fmt;
        packages.default = pkgs.buildFHSEnv {
          name = "webots";
          targetPkgs = pkgs: dependencies;
          runScript = pkgs.writeScript "webots"
            ''
              export QT_PLUGIN_PATH=${webots}/lib/webots/qt/plugins
              export WEBOTS_HOME=${webots}
              exec ${webots}/webots "$@"
            '';
          extraInstallCommands = ''
            mkdir -p $out
            cp -r ${desktopFile}/* $out/
            chmod +w $out/share/applications
            sed -i "s#%%EXEC%%#$out/bin/webots#" $out/share/applications/webots-fhs.desktop
          '';
          meta.description = "Webots in an FHS environment";
        };
        apps.default = {
          type = "app";
          program = "${packages.default}/bin/webots";
        };
        devShells.default = pkgs.mkShell {
          buildInputs = dependencies;
        };
      });
}