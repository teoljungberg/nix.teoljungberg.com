{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { }
}:

let
  dotfiles-tmuxConfig = dotfiles.readFile "tmux.conf";
  tmuxConfig = pkgs.writeText "tmux.conf" dotfiles-tmuxConfig;
in
pkgs.symlinkJoin {
  name = "tmux";
  paths = [ pkgs.tmux ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    bin="$(readlink -v --canonicalize-existing "$out/bin/tmux")"
    rm "$out/bin/tmux"
    makeWrapper $bin "$out/bin/tmux" --add-flags "-f ${tmuxConfig}"
  '';
}
