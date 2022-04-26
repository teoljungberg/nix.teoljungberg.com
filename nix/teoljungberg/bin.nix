{ pkgs ? (import <nixpkgs> { })
, dotfiles-bin ? null
}:

pkgs.runCommand "teoljungberg-dotfiles-bin" { } ''
  mkdir $out
  ln -sf ${dotfiles-bin} $out/bin
''
