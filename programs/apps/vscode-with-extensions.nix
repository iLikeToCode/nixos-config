{
  pkgs,
  lib,
  stdenv,
  runCommand,
  buildEnv,
  vscode,
  vscode-utils,
  jq,
  makeWrapper,
  writeShellScript,
  writeTextFile,
  vscodeExtensions ? [ ],
}:

let
  inherit (vscode) executableName longName;
  wrappedPkgVersion = lib.getVersion vscode;
  wrappedPkgName = lib.removeSuffix "-${wrappedPkgVersion}" vscode.name;

  extensionJsonFile = writeTextFile {
    name = "vscode-extensions-json";
    destination = "/share/vscode/extensions/extensions.json";
    text = vscode-utils.toExtensionJson vscodeExtensions;
  };

  combinedExtensionsDrv = buildEnv {
    name = "vscode-extensions";
    paths = vscodeExtensions ++ [ extensionJsonFile ];
  };
  
  pythonEnv = import ./python-env.nix { inherit pkgs; };

  nixWrapperScript = writeShellScript "nix-vscode-wrapper" ''
    #!/usr/bin/env bash
    set -e

    CODE_REAL="$(dirname "$0")/code-real"
    TARGET="$1"
    shift || true

    # No dir → pass everything through
    if [ -z "$TARGET" ] || [ ! -d "$TARGET" ]; then
      exec "$CODE_REAL" "$TARGET" "$@"
    fi

    # ── flake ─────────────────────────────
    if [ -f "$TARGET/flake.nix" ]; then
      if sh -c "cd '$TARGET' && nix develop --command true" >/dev/null 2>&1; then
        exec sh -c "cd '$TARGET' && nix develop -c '$CODE_REAL' '$TARGET' '$@'"
      fi
    fi

    # ── legacy shell ──────────────────────
    if [ -f "$TARGET/shell.nix" ]; then
      exec sh -c "cd '$TARGET' && nix-shell --run '$CODE_REAL \"$TARGET\" $@'"
    fi

    exec "$CODE_REAL" "$TARGET" "$@"
  ''

  wrapperScript = writeTextFile {
    name = "vscode-wrapper";
    text = ''
      #!/usr/bin/env bash
      set -e

      HOME_DIR="$HOME"
      [ -d "$HOME_DIR" ] || exit 0

      PYTHON="${pythonEnv}/bin/python3.13"

      # Get site-packages of the pythonEnv
      EXTRA_PATHS="$($PYTHON - <<'EOF'
import site, json
print(json.dumps(site.getsitepackages()))
EOF
)"

      # ── VS Code Settings (Pylance) ─────────────
      SETTINGS_DIR="$HOME_DIR/.config/Code/User"
      SETTINGS_FILE="$SETTINGS_DIR/settings.json"
      mkdir -p "$SETTINGS_DIR"

      if [ ! -f "$SETTINGS_FILE" ]; then
        cat > "$SETTINGS_FILE" <<EOF
{
  "workbench.colorTheme": "GitHub Dark",
  "python.defaultInterpreterPath": "$PYTHON",
  "python.analysis.extraPaths": $EXTRA_PATHS,
  "python.analysis.autoImportCompletions": true,
  "python.analysis.typeCheckingMode": "basic"
}
EOF
      else
        ${jq}/bin/jq \
          --arg interp "$PYTHON" \
          --argjson paths "$EXTRA_PATHS" \
          '.["python.defaultInterpreterPath"]=$interp
           | .["python.analysis.extraPaths"]=$paths' \
          "$SETTINGS_FILE" > "$SETTINGS_FILE.tmp" \
          && mv "$SETTINGS_FILE.tmp" "$SETTINGS_FILE"
      fi
    '';
  };


  extensionsFlag = ''
    --add-flags "--extensions-dir ${combinedExtensionsDrv}/share/vscode/extensions"
  '';
in

runCommand "${wrappedPkgName}-with-extensions-${wrappedPkgVersion}"
  {
    nativeBuildInputs = [ makeWrapper ];
    buildInputs = [ vscode ];
    dontPatchELF = true;
    dontStrip = true;
    meta = vscode.meta;
  }
  ''
    mkdir -p "$out/bin"
    mkdir -p "$out/share/applications"
    mkdir -p "$out/share/pixmaps"

    ln -sT "${vscode}/share/pixmaps/vs${executableName}.png" "$out/share/pixmaps/vs${executableName}.png"
    ln -sT "${vscode}/share/applications/${executableName}.desktop" "$out/share/applications/${executableName}.desktop"
    ln -sT "${vscode}/share/applications/${executableName}-url-handler.desktop" "$out/share/applications/${executableName}-url-handler.desktop"

    makeWrapper "${vscode}/bin/${executableName}" "$out/bin/code-real" --run "bash ${wrapperScript}" ${extensionsFlag}
    install -Dm755 ${nixWrapperScript} $out/bin/code
  ''