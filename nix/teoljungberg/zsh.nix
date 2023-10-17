{
  pkgs ? import <nixpkgs> {},
  dotfiles ? import ../dotfiles.nix {},
  env ? import ../env.nix {inherit pkgs dotfiles;},
}: let
  dotfilesZshenv = dotfiles.read "zshenv";
  dotfilesZshrc = dotfiles.read "zshrc";
  ruby = pkgs.ruby_3_0;
  cpathEnv = builtins.getEnv "CPATH";
  libraryPathEnv = builtins.getEnv "LIBRARY_PATH";
  pathEnv = builtins.getEnv "PATH";
  zdotdirZshenv = pkgs.writeText ".zshenv" ''
    ${dotfilesZshenv}

    export CPATH=${env}/include:${cpathEnv}
    export LIBRARY_PATH=${env}/lib:${libraryPathEnv}
    export PATH=$HOME/.gem/ruby/${ruby.version}/bin:${env}/bin:${pathEnv}

    export IN_NIX_SHELL=1
  '';
  zdotdirZshrc = pkgs.writeText ".zshrc" dotfilesZshrc;
  zdotdir = pkgs.buildEnv {
    name = "teoljungberg-zdotdir";
    paths = [
      (
        pkgs.runCommand "zdotdir" {} ''
          mkdir -p $out/zdotdir
          cp ${zdotdirZshenv} $out/zdotdir/.zshenv
          cp ${zdotdirZshrc} $out/zdotdir/.zshrc
        ''
      )
    ];
  };
in
  pkgs.symlinkJoin {
    name = "teoljungberg-nix";
    paths = [pkgs.zsh];
    passthru = {shellPath = pkgs.zsh.shellPath;};
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      bin="$(readlink -v --canonicalize-existing "$out/bin/zsh")"
      rm "$out/bin/zsh"
      makeWrapper $bin "$out/bin/zsh" --set "ZDOTDIR" "${zdotdir}/zdotdir"
    '';
  }
