{ pkgs ? import <nixpkgs> { }
, dotfiles ? ""
}:

let
  dotfiles-bin = dotfiles + "/bin";
  teoljungberg-bin = import ./teoljungberg/bin.nix { inherit pkgs dotfiles-bin; };
  dotfiles-homeManager = import (dotfiles + "/config/nixpkgs/home.nix") { inherit pkgs; };
  homeManagerPackages = dotfiles-homeManager.home.packages;
  paths = homeManagerPackages ++ [ teoljungberg-bin ];
in
pkgs.buildEnv {
  name = "teoljungberg-env";
  paths = paths;
  extraOutputsToInstall = [ "bin" "dev" "lib" ];
}
