{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ./dotfiles.nix { }
}:

let
  teoljungberg = import ./teoljungberg { inherit pkgs dotfiles; };
  dotfiles-homeManager = import (dotfiles.get "config/nixpkgs/home.nix") {
    inherit pkgs;
  };
  homeManagerPackages = dotfiles-homeManager.home.packages;
  excludedPackages = with pkgs; [
    pkgs.git
    pkgs.tmux
    pkgs.vim
  ];
  packagesWithoutCollisions = pkgs.lib.subtractLists
    excludedPackages
    homeManagerPackages;
  paths = packagesWithoutCollisions ++ [
    teoljungberg.git
    teoljungberg.tmux
    teoljungberg.vim
  ] ++ [
    teoljungberg.bin
  ];
in
pkgs.buildEnv {
  name = "teoljungberg-env";
  paths = paths;
  extraOutputsToInstall = [ "bin" "dev" "lib" ];
}
