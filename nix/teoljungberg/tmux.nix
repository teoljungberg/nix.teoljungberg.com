{ pkgs, dotfiles-tmuxConfig }:

let
  tmuxConfig = pkgs.writeText "tmux.conf" tmuxConfig;
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
