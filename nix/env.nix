{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ./dotfiles.nix { inherit pkgs; }
}:

let
  teoljungberg-bin = import ./teoljungberg/bin.nix { inherit pkgs dotfiles; };
  dotfiles-homeManager = import (dotfiles.getFile "config/nixpkgs/home.nix") { inherit pkgs; };
  homeManagerPackages = dotfiles-homeManager.home.packages;
  paths = homeManagerPackages ++ [ teoljungberg-bin ];
in
pkgs.buildEnv {
  name = "teoljungberg-env";
  paths = paths;
  extraOutputsToInstall = [ "bin" "dev" "lib" ];
}
