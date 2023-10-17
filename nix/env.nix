{
  pkgs ? import <nixpkgs> {},
  lib ? pkgs.lib,
  dotfiles ? import ./dotfiles.nix {},
}:
with lib; let
  teoljungberg = import ./teoljungberg {inherit pkgs dotfiles;};
  getHomeManager = host: pkgs:
    import (dotfiles.get "host-" + host + "/config/nixpkgs/home.nix") {
      inherit pkgs;
    };
  dotfilesThymeHomeManager = getHomeManager "thyme" pkgs;
  homeManagerPackages =
    unique
    dotfilesThymeHomeManager.home.packages;
  excludedPackages = with pkgs; [
    git
    tmux
    vim_configurable
  ];
  overriddenPackages = [
    teoljungberg.git
    teoljungberg.tmux
    teoljungberg.vim
  ];
  newPackages = [
    pkgs.postgresql_14
    pkgs.redis
    teoljungberg.bin
  ];
  packagesMatching = pkg1: pkg2:
    (getName pkg1.name) == (getName pkg2.name);
  collidingPackages =
    builtins.filter
    (pkg: any (packagesMatching pkg) excludedPackages)
    homeManagerPackages;
  packagesWithoutCollisions =
    subtractLists
    collidingPackages
    homeManagerPackages;
  paths =
    packagesWithoutCollisions
    ++ overriddenPackages
    ++ newPackages;
in
  pkgs.buildEnv {
    name = "teoljungberg-env";
    paths = paths;
    extraOutputsToInstall = ["bin" "dev" "lib"];
  }
