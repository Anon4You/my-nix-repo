{ pkgs ? import <nixpkgs> {} }:

let
  pkgDirs = builtins.readDir ./pkgs;
  
  isPackage = name: type:
    type == "directory" && builtins.pathExists (./pkgs + "/${name}/default.nix");
  
  packageNames = builtins.attrNames (builtins.filterAttrs isPackage pkgDirs);
  
in
builtins.listToAttrs (map (name: {
  inherit name;
  value = pkgs.callPackage (./pkgs + "/${name}/default.nix") { };
}) packageNames)
