{ pkgs, ... }:
pkgs.opencv.override {
    enableGtk3 = true;
}