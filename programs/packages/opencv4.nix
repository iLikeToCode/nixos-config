{ pkgs, ... }:
pkgs.python313Packages.opencv4Full.override {
    enableGtk3 = true;
}