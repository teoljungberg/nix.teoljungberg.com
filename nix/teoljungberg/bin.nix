{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { inherit pkgs; }
}:

let
  dotfiles-bin = dotfiles + "/bin";
in
pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
  mkdir -p $out/bin
  cp ${dotfiles-bin}/* $out/bin/
''
