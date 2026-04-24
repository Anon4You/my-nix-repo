{ pkgs ? import <nixpkgs> {} }:

let
  pkgDirs = builtins.readDir ./pkgs;
  # List of names that are directories and contain default.nix
  pkgNames = builtins.filter (name:
    let t = pkgDirs.${name}; in
    t == "directory" && builtins.pathExists (./pkgs + "/${name}/default.nix")
  ) (builtins.attrNames pkgDirs);
  
  # Build attr set from list
  result = builtins.listToAttrs (map (name: {
    inherit name;
    value = pkgs.callPackage (./pkgs + "/${name}/default.nix") { };
  }) pkgNames);
in
result
