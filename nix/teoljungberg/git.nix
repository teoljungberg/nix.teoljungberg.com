{ pkgs, dotfiles-gitConfig }:

let
  gitConfig = pkgs.writeTextDir "gitconfig" dotfiles-gitConfig;
in
pkgs.symlinkJoin {
  name = "git";
  paths = [ pkgs.git ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    bin="$(readlink -v --canonicalize-existing "$out/bin/git")"
    rm "$out/bin/git"
    makeWrapper $bin "$out/bin/git" --set "XDG_CONFIG_HOME" "${gitConfig}"
  '';
}
