{ pkgs, ruby, dotfiles-zshenv, dotfiles-zshrc }:

let
  cpathEnv = builtins.getEnv "CPATH";
  libraryPathEnv = builtins.getEnv "LIBRARY_PATH";
  pathEnv = builtins.getEnv "PATH";
  zdotdir-zshenv = pkgs.writeText ".zshenv" dotfiles-zshenv;
  zdotdir-zshrc = pkgs.writeText ".zshrc" dotfiles-zshrc;
  zdotdir = pkgs.buildEnv {
    name = "teoljungberg-zdotdir";
    paths = [
      (
        pkgs.runCommand "zdotdir" { } ''
          mkdir -p $out/zdotdir
          cp ${zdotdir-zshenv} $out/zdotdir/.zshenv
          cp ${zdotdir-zshrc} $out/zdotdir/.zshrc
        ''
      )
    ];
  };
in
pkgs.symlinkJoin {
  name = "zsh";
  paths = [ pkgs.zsh ];
  passthru = { shellPath = pkgs.zsh.shellPath; };
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    bin="$(readlink -v --canonicalize-existing "$out/bin/zsh")"
    rm "$out/bin/zsh"
    makeWrapper $bin "$out/bin/zsh" --set "ZDOTDIR" "${zdotdir}/zdotdir"
  '';
}
