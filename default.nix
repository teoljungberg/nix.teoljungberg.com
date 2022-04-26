let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") { };
  lib = pkgs.lib;
  stdenv = pkgs.stdenv;

  dotfiles = fetchTarball "https://github.com/teoljungberg/dotfiles/archive/master.tar.gz";
  teoljungberg = import ./nix/teoljungberg { inherit pkgs dotfiles; };

  env = pkgs.buildEnv {
    name = "teoljungberg-env";
    paths = [
      teoljungberg.bin
      teoljungberg.git
      teoljungberg.tmux
      teoljungberg.vim
      teoljungberg.zsh
    ];
    extraOutputsToInstall = [ "bin" "dev" "lib" ];
  };

  zsh = teoljungberg.zsh;
in
if lib.inNixShell then
  pkgs.mkShell { shellHook = "${zsh}${zsh.shellPath}; exit $?"; }
else
  zsh
