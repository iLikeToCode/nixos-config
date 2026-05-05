{ pkgs, ... }:
pkgs.python313Packages.opencv4.override {
    enableGtk3 = true;
}