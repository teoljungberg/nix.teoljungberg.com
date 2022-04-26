{ pkgs, dotfiles-bin }:

pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
  mkdir -p $out/bin
  cp ${dotfiles-bin}/* $out/bin/
''
