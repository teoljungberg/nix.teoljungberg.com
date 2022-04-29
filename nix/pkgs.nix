{ dotfiles ? import ./dotfiles.nix { } }:

let
  overlays = import (dotfiles.getFile "config/nixpkgs/overlays.nix");
  pkgs = (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/21.11.tar.gz") {
      inherit overlays;
    }
  );
in
pkgs
