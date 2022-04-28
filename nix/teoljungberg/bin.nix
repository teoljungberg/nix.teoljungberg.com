{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { }
}:

let
  dotfiles-bin = dotfiles.getFile "bin";
in
pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
  mkdir -p $out/bin
  ln -s ${dotfiles-bin}/* $out/bin/
''
