{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { inherit pkgs; }
}:

let
  env = import ../env.nix { inherit pkgs dotfiles; };
  dotfiles-gitConfig = builtins.readFile (dotfiles + "/gitconfig");
  dotfiles-tmuxConfig = builtins.readFile (dotfiles + "/tmux.conf");
  dotfiles-vimrc = builtins.readFile (dotfiles + "/vimrc");
  dotfiles-zshrc = builtins.readFile (dotfiles + "/zshrc");
  dotfiles-zshenv = builtins.readFile (dotfiles + "/zshenv");
  dotfiles-homeManager = builtins.readFile (dotfiles + "/config/nixpkgs/home.nix");
in
{
  git = pkgs.callPackage ./git.nix { inherit pkgs dotfiles-gitConfig; };
  tmux = pkgs.callPackage ./tmux.nix { inherit pkgs dotfiles-tmuxConfig; };
  vim = pkgs.callPackage ./vim.nix { inherit pkgs dotfiles-vimrc; };
  zsh = pkgs.callPackage ./zsh.nix {
    inherit pkgs dotfiles-zshrc dotfiles-zshenv env;
    ruby = pkgs.ruby_3_0;
  };
}
