{ pkgs ? import <nixpkgs> { }
, localCheckout ? false
}:

let
  stdenv = pkgs.stdenv;
  home =
    if stdenv.isDarwin then
      "/Users/teo"
    else
      "/home/teo";
in
if localCheckout then
  "${home}/src/github.com/teoljungberg/dotfiles"
else
  fetchTarball "https://github.com/teoljungberg/dotfiles/archive/master.tar.gz"
