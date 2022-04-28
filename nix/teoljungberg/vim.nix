{ pkgs ? import <nixpkgs> { }
, dotfiles ? import ../dotfiles.nix { }
}:

let
  dotfiles-vimrc = dotfiles.readFile "vimrc";
in
pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.customRC = dotfiles-vimrc;
  vimrcConfig.packages.bundle = with pkgs.vimPlugins; {
    start = [
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
      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-bundler";
        version = "2.1";
        src = pkgs.fetchFromGitHub {
          owner = "tpope";
          repo = "vim-bundler";
          rev = "v2.1";
          sha256 = "1050qnqdkgp1j1jj1a8g5b8klyb7s4gi08hhz529zm8fsdmzj1ca";
        };
      })
      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-rake";
        version = "2021-06-07";
        src = pkgs.fetchFromGitHub {
          owner = "tpope";
          repo = "vim-rake";
          rev = "34ece18ac8f2d3641473c3f834275c2c1e072977";
          sha256 = "1ff0na01mqm2dbgncrycr965sbifh6gd2wj1vv42vfgncz8l331a";
        };
      })
      (pkgs.vimUtils.buildVimPluginFrom2Nix {
        pname = "vim-whitescale";
        version = "2021-06-07";
        src = pkgs.fetchFromGitHub {
          owner = "teoljungberg";
          repo = "vim-whitescale";
          rev = "44b2e4531d8f2f4d11e4c5fe2216187c0a993e13";
          sha256 = "0hlxww8njmw61ipxwvymqcc7h58h38k6444v3nf11gwdqkj0pnxg";
        };
      })
    ];
  };
}
