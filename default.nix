let
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") { };
  lib = pkgs.lib;
  stdenv = pkgs.stdenv;

  dotfiles = fetchTarball "https://github.com/teoljungberg/dotfiles/archive/master.tar.gz";
  env = import ./nix/env.nix { inherit pkgs dotfiles; };
  teoljungberg = import ./nix/teoljungberg { inherit pkgs dotfiles env; };

  zsh = teoljungberg.zsh;
in
if lib.inNixShell then
  pkgs.mkShell { shellHook = "${zsh}${zsh.shellPath}; exit $?"; }
else
  zsh
