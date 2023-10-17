{dotfiles ? import ./dotfiles.nix {}}: let
  overlays = import (dotfiles.get "nixpkgs/overlays.nix");
  pkgs = (
    import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/22.05.tar.gz") {
      inherit overlays;
    }
  );
in
  pkgs
