{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { }
, env ? import ../env.nix { inherit pkgs dotfiles; }
}:

{
  bin = pkgs.callPackage ./bin.nix { inherit pkgs dotfiles; };
  git = pkgs.callPackage ./git.nix { inherit pkgs dotfiles; };
  tmux = pkgs.callPackage ./tmux.nix { inherit pkgs dotfiles; };
  vim = pkgs.callPackage ./vim.nix { inherit pkgs dotfiles; };
  zsh = pkgs.callPackage ./zsh.nix { inherit pkgs dotfiles env; };
}
