{ pkgs, dotfiles-bin }:

pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
  mkdir -p $out/bin/
  ln -s ${dotfiles-bin}/* $out/bin/
''
