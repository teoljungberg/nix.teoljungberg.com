{ pkgs ? import <nixpkgs> { }
, ruby ? pkgs.ruby_3_0
, dotfiles ? ""
}:

let
  dotfiles-bin = dotfiles + "/bin";
  dotfiles-gitConfig = builtins.readFile (dotfiles + "/gitconfig");
  dotfiles-tmuxConfig = builtins.readFile (dotfiles + "/tmux.conf");
  dotfiles-vimrc = builtins.readFile (dotfiles + "/vimrc");
  dotfiles-zshrc = builtins.readFile (dotfiles + "/zshrc");
  dotfiles-zshenv = builtins.readFile (dotfiles + "/zshenv");
  dotfiles-homeManager = builtins.readFile (dotfiles + "/config/nixpkgs/home.nix");
in
{
  bin = pkgs.callPackage ./bin.nix { inherit pkgs dotfiles-bin; };
  git = pkgs.callPackage ./git.nix { inherit pkgs; };
  tmux = pkgs.callPackage ./tmux.nix { inherit pkgs; };
  vim = pkgs.callPackage ./vim.nix { inherit pkgs dotfiles-vimrc; };
  zsh = pkgs.callPackage ./zsh.nix {
    inherit pkgs ruby dotfiles-zshrc dotfiles-zshenv;
  };
}
