{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { }
}:

let
  dotfilesBin = dotfiles.get "bin";
in
pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
  mkdir -p $out/bin
  ln -s ${dotfilesBin}/* $out/bin/
''
