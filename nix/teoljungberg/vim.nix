{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { }
}:

let
  dotfilesVimrc = dotfiles.read "vimrc";
in
pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = dotfilesVimrc;
  vimrcConfig.packages.bundle = {
    start = with pkgs.vimPlugins; [
      ale
      fzf-vim
      splitjoin-vim
      vim-abolish
      vim-commentary
      vim-dispatch
      vim-endwise
      vim-eunuch
      vim-exchange
      vim-fugitive
      vim-git
      vim-markdown
      vim-nix
      vim-projectionist
      vim-rails
      vim-repeat
      vim-rhubarb
      vim-ruby
      vim-scriptease
      vim-sleuth
      vim-surround
      vim-unimpaired
      vim-vinegar
      (
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-bundler";
          version = "2022-04-28";
          src = pkgs.fetchFromGitHub {
            owner = "tpope";
            repo = "vim-bundler";
            rev = "d66708fe0fd2d139ec6a2870dd94d813509f784d";
            sha256 = "He8GMiNc9eVAl8mvhbYuwOOmLbGMjtULAE4YnVrwfr4=";
          };
        }
      )
      (
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-rake";
          version = "2022-04-28";
          src = pkgs.fetchFromGitHub {
            owner = "tpope";
            repo = "vim-rake";
            rev = "6b6ac578c27f0625f23164a8f9dc104578d32859";
            sha256 = "0vEGog0syxqT+ucVAlcSVzGJVNeAmg7JYxJ4i3pf07c=";
          };
        }
      )
      (
        pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "vim-whitescale";
          version = "2022-04-28";
          src = pkgs.fetchFromGitHub {
            owner = "teoljungberg";
            repo = "vim-whitescale";
            rev = "65d3ce1e20e3f2111a5f1b76752231e9bc824631";
            sha256 = "eftxpI46bcc9uRCWRdk1m9YkDlSm7sp8oW7yBGtTl7I=";
          };
        }
      )
    ];
  };
}
