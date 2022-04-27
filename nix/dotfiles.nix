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
  location =
    if localCheckout then
      "${home}/src/github.com/teoljungberg/dotfiles"
    else
      fetchTarball "https://github.com/teoljungberg/dotfiles/archive/master.tar.gz";
  readFile = path: builtins.readFile (getFile (path));
  getFile = path: location + "/" + path;
in
{
  readFile = readFile;
  getFile = getFile;
}
