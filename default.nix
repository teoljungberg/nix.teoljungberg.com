{ pkgs ? (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") { }
  )
, localCheckout ? false
}:

let
  lib = pkgs.lib;

  dotfiles = import ./nix/dotfiles.nix { inherit pkgs localCheckout; };
  teoljungberg = import ./nix/teoljungberg { inherit pkgs dotfiles; };

  zsh = teoljungberg.zsh;
in
if lib.inNixShell then
  pkgs.mkShell { shellHook = "${zsh}${zsh.shellPath}; exit $?"; }
else
  zsh
