{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { inherit pkgs; }
, env ? import ../env.nix { inherit pkgs dotfiles; }
}:

let
  dotfiles-zshenv = dotfiles.readFile "zshenv";
  dotfiles-zshrc = dotfiles.readFile "zshrc";
  ruby = pkgs.ruby_3_0;
  cpathEnv = builtins.getEnv "CPATH";
  libraryPathEnv = builtins.getEnv "LIBRARY_PATH";
  pathEnv = builtins.getEnv "PATH";
  zdotdir-zshenv = pkgs.writeText ".zshenv" ''
    ${dotfiles-zshenv}

    export CPATH=${env}/include:${cpathEnv}
    export LIBRARY_PATH=${env}/lib:${libraryPathEnv}
    export PATH=$HOME/.gem/ruby/${ruby.version}/bin:${env}/bin:${pathEnv}

    export IN_NIX_SHELL=1
  '';
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
