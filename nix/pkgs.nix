{ dotfiles ? import ./dotfiles.nix { } }:

let
  pkgs = (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") {
      overlays = import (dotfiles.getFile "config/nixpkgs/overlays.nix");
    }
  );
in
pkgs
