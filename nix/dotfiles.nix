{ pkgs }:

let
 stdenv = pkgs.stdenv;
  home =
    if stdenv.isDarwin then
      "/Users/teo"
    else
      "/home/teo";
in
  "${home}/src/github.com/teoljungberg/dotfiles"
