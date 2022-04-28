{ localCheckout ? false }:

let
  dotfiles = import ./nix/dotfiles.nix { inherit localCheckout; };
  pkgs = import ./nix/pkgs.nix { inherit dotfiles; };
  env = import ./nix/env.nix { inherit pkgs dotfiles; };
  teoljungberg = import ./nix/teoljungberg { inherit pkgs dotfiles env; };

  zsh = teoljungberg.zsh;
in
if pkgs.lib.inNixShell then
  pkgs.mkShell { shellHook = "${zsh}${zsh.shellPath}; exit $?"; }
else
  zsh
